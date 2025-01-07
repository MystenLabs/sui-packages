module 0x441144d68f36f96c9b2a5a723477e6b7b2d2011ff8569264917fe07b7408690d::cr7 {
    struct CR7 has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<CR7>, arg1: 0x2::coin::Coin<CR7>) {
        0x2::coin::burn<CR7>(arg0, arg1);
    }

    fun init(arg0: CR7, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CR7>(arg0, 9, b"CR7", b"Cristiano Ronaldo", b"https://4.bp.blogspot.com/-IMStsQ4DUO4/W8OFc0aTGdI/AAAAAAAANYE/g8OEeC9HDC4Olx3JB4Zg4uk8OGUC7294QCK4BGAYYCw/s1600/Cristiano%2BRonaldo%2Bgo%2Bprofile%2B1.png", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CR7>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CR7>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<CR7>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CR7>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}


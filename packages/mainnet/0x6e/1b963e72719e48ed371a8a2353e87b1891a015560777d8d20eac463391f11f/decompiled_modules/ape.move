module 0x6e1b963e72719e48ed371a8a2353e87b1891a015560777d8d20eac463391f11f::ape {
    struct APE has drop {
        dummy_field: bool,
    }

    fun init(arg0: APE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APE>(arg0, 6, b"APE", b"ApeSui", b"Telegram: https://t.me/apesui_ann", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/uY9apzk.png"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<APE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APE>>(v0, @0xfb376d3d2282d556e7fc1a7a20af3394d89576f1633af6f078fcb36f53da2514);
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<APE>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<APE>(arg0, arg2, arg1, arg3);
    }

    // decompiled from Move bytecode v6
}


module 0x7f02b997ed1d97e2184ba4cfa066482f52e926bd893c7a1b758d5817d0b98b04::fortyseventhpresident {
    struct FORTYSEVENTHPRESIDENT has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<FORTYSEVENTHPRESIDENT>, arg1: 0x2::coin::Coin<FORTYSEVENTHPRESIDENT>) {
        0x2::coin::burn<FORTYSEVENTHPRESIDENT>(arg0, arg1);
    }

    fun init(arg0: FORTYSEVENTHPRESIDENT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FORTYSEVENTHPRESIDENT>(arg0, 9, b"47TH", b"47th President", b"The 47th President Token represents more than just a digital currency; it embodies Trump's unshakeable commitment to his values and the unwavering loyalty of his supporters. By leveraging the Sui Chain's cutting-edge blockchain technology, this token ensures a secure, transparent, and efficient transaction experience.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1882704240113537024/HunmKlQE_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FORTYSEVENTHPRESIDENT>>(v1);
        0x2::coin::mint_and_transfer<FORTYSEVENTHPRESIDENT>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FORTYSEVENTHPRESIDENT>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<FORTYSEVENTHPRESIDENT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<FORTYSEVENTHPRESIDENT>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}


module 0xccd42284581ea6cbe242f5df1947207da3ff04de8038d9cd31715eb297b2cb89::danielsui {
    struct DANIELSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DANIELSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DANIELSUI>(arg0, 6, b"Danielsui", b"Daniel Sui", b"DANIEL SUI! Launching on SUI as a truly community owned meme coin for fans of the karate kid and Cobra Kia. Let the creativity begin.. Wax on, Wax off", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mr_mi2_ff217aaecd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DANIELSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DANIELSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}


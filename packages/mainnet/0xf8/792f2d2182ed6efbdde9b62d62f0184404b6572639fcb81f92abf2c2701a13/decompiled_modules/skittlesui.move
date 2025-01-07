module 0xf8792f2d2182ed6efbdde9b62d62f0184404b6572639fcb81f92abf2c2701a13::skittlesui {
    struct SKITTLESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKITTLESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKITTLESUI>(arg0, 6, b"SKITTLESUI", b"SKITTLESSUI", b"Hey every one! My name is Skittles! Yes, I am real! I am coming to SUI Network! I have lots of pictures and selfies to share! I bring a very exciting and lengthy roadmap for the SUI Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6894486575403610509_1_6892b2cb58.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKITTLESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKITTLESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}


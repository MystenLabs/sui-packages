module 0x273e0df87161787d972638a9ad217eb1e1ba08f4e75cc91763efe3c2a63650e4::eater {
    struct EATER has drop {
        dummy_field: bool,
    }

    fun init(arg0: EATER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EATER>(arg0, 6, b"Eater", b"Sui Eater", b"I'll take her soul for you Chad's and spit it out on Dex", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000012292_3bdd786db6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EATER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EATER>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x7ced012b629a978a4192ffc55f599d55fe99d05bb360d462908d8e5d051f0fb8::kai {
    struct KAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAI>(arg0, 6, b"KAI", b"kingai", b"xxxx", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/elephant_7a8733c723.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KAI>>(v1);
    }

    // decompiled from Move bytecode v6
}


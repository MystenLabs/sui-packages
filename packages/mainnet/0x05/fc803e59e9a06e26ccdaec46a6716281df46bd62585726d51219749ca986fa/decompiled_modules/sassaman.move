module 0x5fc803e59e9a06e26ccdaec46a6716281df46bd62585726d51219749ca986fa::sassaman {
    struct SASSAMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SASSAMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SASSAMAN>(arg0, 6, b"SASSAMAN", b"Len Sassaman", b"In 2011, he passed away by suicide at the age of 31. He was a doctoral student in electrical engineering at KU Leuven in Belgium at the time. A memorial to him was encoded into the Bitcoin blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/NEW_35e386d75d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SASSAMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SASSAMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}


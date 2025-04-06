module 0x8fc840c77ad4fdad6b93f9892d76b973b2770af424851a1f240a7777e6dffe02::pkas {
    struct PKAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PKAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PKAS>(arg0, 6, b"PKAS", b"PikaSui", b"PikaSui may be cutest, but don't mistake kindness for weakness. PikaSui is just a fun meme coin on sui network with no utility. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/file_00000000d7a451f79645e1371f7912ce_conversation_id_67f2127c_da14_8000_ba63_1766309ff83e_and_message_id_1bce0205_5e95_44c7_98e2_40409be86826_Edited_26695380b3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PKAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PKAS>>(v1);
    }

    // decompiled from Move bytecode v6
}


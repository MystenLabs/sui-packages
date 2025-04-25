module 0xea7b60b72ac43c90636e0fce699a263bee4ce1289066c005fe2026807edca64d::csm {
    struct CSM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CSM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CSM>(arg0, 9, b"CSM", b"coinsuime", b"test sui7K", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/7ac38d46aef594852d10765d1511196eblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CSM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CSM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0x8dd458209bd7d74fff88deb4024581d6747e63faf465d309521ae4ee502d0aed::otf {
    struct OTF has drop {
        dummy_field: bool,
    }

    fun init(arg0: OTF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OTF>(arg0, 6, b"OTF", b"OTTERFLY SUI", b"This is $OTF a flying otter from uptober with many adorable facial expressions.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731315697621.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OTF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OTF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


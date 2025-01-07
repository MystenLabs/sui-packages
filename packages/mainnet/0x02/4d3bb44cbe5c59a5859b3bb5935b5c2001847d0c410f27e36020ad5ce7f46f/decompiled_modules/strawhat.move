module 0x24d3bb44cbe5c59a5859b3bb5935b5c2001847d0c410f27e36020ad5ce7f46f::strawhat {
    struct STRAWHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: STRAWHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STRAWHAT>(arg0, 6, b"STRAWHAT", b"StrawhatOnSui", b"The king of pirates is now sailing in the Sui Ocean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241003_153540_7aa6d0ad93.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STRAWHAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STRAWHAT>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x7902c4652132ae8b6dd00f25640cead499d5bab7daa7e748f3a644adae2eff7a::tzu {
    struct TZU has drop {
        dummy_field: bool,
    }

    fun init(arg0: TZU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TZU>(arg0, 6, b"Tzu", b"sui tzu", b"meet sui tzu, the mascot of the sui chain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sui_tzuh_72f8529642.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TZU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TZU>>(v1);
    }

    // decompiled from Move bytecode v6
}


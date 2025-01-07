module 0x6877e7c410d743103ccde632ead4ccdfcc21039ab24dea5cbd12729a8460a9ca::final {
    struct FINAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: FINAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FINAL>(arg0, 6, b"FINAL", b"Final", b"final", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/F_Dog_716bc325d2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FINAL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FINAL>>(v1);
    }

    // decompiled from Move bytecode v6
}


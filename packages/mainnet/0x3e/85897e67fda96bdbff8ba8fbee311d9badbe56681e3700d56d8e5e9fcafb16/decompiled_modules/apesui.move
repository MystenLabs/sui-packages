module 0x3e85897e67fda96bdbff8ba8fbee311d9badbe56681e3700d56d8e5e9fcafb16::apesui {
    struct APESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: APESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APESUI>(arg0, 6, b"APESUI", b"APE SUI", b"APESUI is the future in the memecoin world this time on SUI! @stackdrow ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000008798_68cfe08aaf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}


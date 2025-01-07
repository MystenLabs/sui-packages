module 0x7286930c683dc061dd3e60f0af824b01126f59a7f7dda9df3beaac9e33e57e01::superjesuis {
    struct SUPERJESUIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPERJESUIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPERJESUIS>(arg0, 6, b"SuperJesuis", b"Super Jesuis", b"Super Jesius has arrived to the Sui Network. Together we will rise and protect Sui's ecosystem and rise through the ranks with the power of prayer! Now, let us pray....", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Super_jesus_56d14c0bf6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPERJESUIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUPERJESUIS>>(v1);
    }

    // decompiled from Move bytecode v6
}


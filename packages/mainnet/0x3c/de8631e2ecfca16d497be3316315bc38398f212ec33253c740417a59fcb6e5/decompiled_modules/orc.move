module 0x3cde8631e2ecfca16d497be3316315bc38398f212ec33253c740417a59fcb6e5::orc {
    struct ORC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORC>(arg0, 6, b"ORC", b"Orc On Sui", b"Time for your next adventure.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/e37fef4a7396af0459478469a7b2df2e_881b4fadad.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ORC>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x66045369cb9d5133a4275fe0a12d36c25833cd41b554d7a2dae49451cdf4cbc9::fud {
    struct FUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUD>(arg0, 6, b"FUD", b"Fuddies", b"FUD around and find out", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/x_O_Rzt_FXI_400x400_6f4197534d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUD>>(v1);
    }

    // decompiled from Move bytecode v6
}


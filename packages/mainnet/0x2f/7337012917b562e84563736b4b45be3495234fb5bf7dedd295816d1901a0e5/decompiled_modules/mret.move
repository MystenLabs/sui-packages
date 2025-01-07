module 0x2f7337012917b562e84563736b4b45be3495234fb5bf7dedd295816d1901a0e5::mret {
    struct MRET has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRET>(arg0, 6, b"MRET", b"Mr.ET", b"Mr.ET on patrol dudes, be careful with him and don't let him examine ur holes, his finger is kinda weird!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/356616246_3471036389806787_6659361183555346289_n_3143eac020.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MRET>>(v1);
    }

    // decompiled from Move bytecode v6
}


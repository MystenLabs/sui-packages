module 0xec57f0c582ee62b0333f7b40d3080600ed197cd6978015058d1d5486b1af9e3a::susifun {
    struct SUSIFUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUSIFUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUSIFUN>(arg0, 6, b"SUSIFUN", b"SUSI", x"50554d5020414e442046554e2e0a42652070617469656e7420686572652c207468656e2049276c6c206c6f6f6b20666f722050554d502e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000409502_6b480ec50d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUSIFUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUSIFUN>>(v1);
    }

    // decompiled from Move bytecode v6
}


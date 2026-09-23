module 0x106a61f8bae751fbd955e957431ab73a595784ce97bf4e30138b92c939209ca4::blast {
    struct BLAST has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLAST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLAST>(arg0, 9, b"BLAST", b"Blast.fun", b"Clear for launch.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://launchdesk.38.242.215.238.sslip.io/assets/1f9da1fe217f10cccd1479ac8eff191903c25fba5bf4e4a610835f09d3848875.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLAST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLAST>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


module 0x4adc913314cdf110604d1c34516dc63616f390a9c541be4ae0c397b835da254d::cartl {
    struct CARTL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CARTL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CARTL>(arg0, 6, b"CARTL", b"Cartel", b"Introducing sui $Cartel, Coming in full gangster force to take over the sui memecoin ranks", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeictvubxsgigbbde2euqalkackrkwq4tq2smsidy62sbpt7wdxt2ie")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CARTL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CARTL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


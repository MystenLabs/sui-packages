module 0xb6d7ccc599211d7af0c0de1b78e4e059c0af616b2bda2eb3f06195f17e141bff::tko {
    struct TKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TKO>(arg0, 9, b"TKO", b"Takibi", b"Takibi is an NFT based protocol where users able to Mint Takibi NFT. Use cases will be revealed later. Eligibility condition is basd on amount token on hold by holders.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/d1e916e7991ac7e1dc7eadcb6e577b47blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TKO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TKO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


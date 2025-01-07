module 0x9f5706fe97ce489b63ed4803daab51ff80cdc3d0091f1f13027325564dca6d62::lion {
    struct LION has drop {
        dummy_field: bool,
    }

    fun init(arg0: LION, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LION>(arg0, 6, b"Lion", b"The Lion King", b"The King of MEME on the Sui Public Chain ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731206972435.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LION>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LION>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


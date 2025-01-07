module 0x682969142e5a7523c3cadcd5932307434de8b6a34d461516c069d191bb973890::degen {
    struct DEGEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEGEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEGEN>(arg0, 9, b"DEGEN", b"Degen", b"The Official Links - https://linktr.ee/degen_news", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://bronze-solid-dragonfly-121.mypinata.cloud/ipfs/QmSStEpYTKqZRbmKY2mrFzTwj69SD6imEH9soKVCtXGTkG")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DEGEN>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEGEN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEGEN>>(v1);
    }

    // decompiled from Move bytecode v6
}


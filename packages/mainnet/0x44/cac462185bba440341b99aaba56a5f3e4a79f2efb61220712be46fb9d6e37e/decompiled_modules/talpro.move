module 0x44cac462185bba440341b99aaba56a5f3e4a79f2efb61220712be46fb9d6e37e::talpro {
    struct TALPRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TALPRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TALPRO>(arg0, 9, b"TAL", b"TalPro", b"TalPro is a decentralized Talent Management system on the SUI blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/HwBb1Vi_FsfDcx23LnIOM7QpCcNBhPDmhLaE_gZkC-A")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TALPRO>>(v1);
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<TALPRO>(&mut v2, 1000000000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TALPRO>>(v2, v3);
    }

    // decompiled from Move bytecode v6
}


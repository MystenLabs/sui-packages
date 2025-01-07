module 0xb87572debfdb3e4a36713ba057191da93a6da6398e619b7f5410bae07244210b::jpoowel {
    struct JPOOWEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: JPOOWEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JPOOWEL>(arg0, 6, b"JPOOWEL", b"Joram Poowel", b"Joram Poowel pair launch on Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn1.gstatic.com/images?q=tbn:ANd9GcSOVTXKxL6EVBS1ZPkVfaSKYZAzP_CxVmkj2PYrBOC9u9Zlk9nE")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<JPOOWEL>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JPOOWEL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JPOOWEL>>(v1);
    }

    // decompiled from Move bytecode v6
}


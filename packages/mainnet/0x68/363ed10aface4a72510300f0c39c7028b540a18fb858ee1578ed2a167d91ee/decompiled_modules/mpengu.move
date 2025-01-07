module 0x68363ed10aface4a72510300f0c39c7028b540a18fb858ee1578ed2a167d91ee::mpengu {
    struct MPENGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MPENGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MPENGU>(arg0, 6, b"MPENGU", b"MUTANT PENGU", b"The UMBRELLA CORPORATION has struck again. Not on humans, but on PENGUS!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/222_ce893cd4f7.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MPENGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MPENGU>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x371a99d693ac80c5fc0b97cd4ca0f90511f3b4ab7230c266151da39dbbc596fe::py {
    struct PY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PY>(arg0, 6, b"PY", b"Suipy", b"The Three Legged MEME cat! $Suipy -- Real Story - Fair Launched - NO Pre Sale - NO Pre Allocation! Feed the CAT and grow the MARKET CAP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_a_c_20240921171055_39b7e71a87.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PY>>(v1);
    }

    // decompiled from Move bytecode v6
}


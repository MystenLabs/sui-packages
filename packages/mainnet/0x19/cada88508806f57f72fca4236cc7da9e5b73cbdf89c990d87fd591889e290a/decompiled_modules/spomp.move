module 0x19cada88508806f57f72fca4236cc7da9e5b73cbdf89c990d87fd591889e290a::spomp {
    struct SPOMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPOMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPOMP>(arg0, 6, b"sPOMP", b"POMP (Sui)", x"73504f4d50206973206c61756e636865642062792074686520504f4d50207465616d206f6e2053554920636861696e2e20504f4d5020697320612054415020746f204561726e20616e642061206d656d65206c61756e63687061642c206d61646520627920646567656e7320666f722074686520646567656e732e204261636b656420627920746f70206d656d65207472616465727320696e207468652063727970746f206d61726b65742e0a0a436f6e6669726d207468652061757468656e746963697479206f66207468652073504f4d50206f6e206f75722074656c656772616d206368616e6e656c2e0a0a4c65747320676f21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_03_15_16_04_aa8588fc59.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPOMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPOMP>>(v1);
    }

    // decompiled from Move bytecode v6
}


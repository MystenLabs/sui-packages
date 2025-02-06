module 0x1f4a792423310daeb32ead55937c0bb5f39726f7d7e00c96021578cc74d1a416::bld {
    struct BLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLD>(arg0, 9, b"BLD", b"BERALEND", x"2a546f6b656e20426572616c656e642028424c44292a0a546f6b656e20426572616c656e642028424c4429206164616c616820746f6b656e207574696c697461732079616e672064696b656d62616e676b616e20756e74756b206d656e64756b756e6720656b6f73697374656d2053756920426572616c656e64", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7344d1da-1975-4830-b7d1-ee4b45a69d46.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLD>>(v1);
    }

    // decompiled from Move bytecode v6
}


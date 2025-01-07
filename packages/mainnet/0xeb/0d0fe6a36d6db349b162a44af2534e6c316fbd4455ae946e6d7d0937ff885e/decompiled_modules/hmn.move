module 0xeb0d0fe6a36d6db349b162a44af2534e6c316fbd4455ae946e6d7d0937ff885e::hmn {
    struct HMN has drop {
        dummy_field: bool,
    }

    fun init(arg0: HMN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HMN>(arg0, 9, b"HMN", b"HUMAN", x"456d706f776572207468652066757475726520776974682048554d414e204d656d65636f696e2c2061206469676974616c2063757272656e637920696e7370697265642062792074686520657373656e6365206f662068756d616e69747920616e642074686520706f776572206f662068756d616e20636f6e6e656374696f6e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0edd27a2-bd26-40ff-b91a-b56ed005325e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HMN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HMN>>(v1);
    }

    // decompiled from Move bytecode v6
}


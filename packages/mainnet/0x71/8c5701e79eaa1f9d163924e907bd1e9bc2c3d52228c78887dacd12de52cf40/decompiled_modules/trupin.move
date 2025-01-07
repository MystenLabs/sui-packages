module 0x718c5701e79eaa1f9d163924e907bd1e9bc2c3d52228c78887dacd12de52cf40::trupin {
    struct TRUPIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUPIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUPIN>(arg0, 6, b"TruPin", b"TruPin on sui", b"When Trump and Putin decide to pump together, even crypto kneels! Ready for the ultimate 'power duo' meme revolution?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tru_Pin_a52871bf37.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUPIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUPIN>>(v1);
    }

    // decompiled from Move bytecode v6
}


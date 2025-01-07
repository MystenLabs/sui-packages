module 0x2ef0955bb3c91f03fafd2fa4c464134c196101c42a19b1158c95bebdbfafc96e::adam {
    struct ADAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADAM>(arg0, 6, b"ADAM", b"ADAM BUNNY", x"244144414d2074686520626c7565207261626269742c20697320726561647920746f207475726e20757020746865206368616f73206f6e205375692e20546865206d6f6e6579207072696e7465722069732061206d616e696163212042525252525252206164616d62756e6e792e78797a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/456546889_796c99cf03_f88acb5eb7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ADAM>>(v1);
    }

    // decompiled from Move bytecode v6
}


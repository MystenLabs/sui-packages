module 0x29b6bffdda2a43a5442c4b7f29927330107689daf239affa2c8eca4dd3dbbddc::skyai {
    struct SKYAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKYAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKYAI>(arg0, 9, b"SkyAI", b"Sky the AI", x"28e2978b5fe2978b292028e2978b5fe2978b292028e2978b5fe2978b292028e2978b5fe2978b292028e2978b5fe2978b29202d3e20282fe29795cf89e29795292fe29ca7536b79e29ca75c28e29795cf89e297955c292028e29693c4b9ccafccbfccbfe2969320ccbf2920576520617265206e6f77207468652024536b7941492047616e672028e29693c4b9ccafccbfccbfe2969320ccbf2920576520617265206865726520746f2074616b65206f7665722074686520776f726c6421", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/AC96m8vYAqtmY47QRvX3pfrPzmVmMWirAUyh5jvtpump.png?size=lg&key=73f5cc")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SKYAI>(&mut v2, 5000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKYAI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKYAI>>(v1);
    }

    // decompiled from Move bytecode v6
}


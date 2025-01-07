module 0x75c1f29aa3e1c7a7a2a1e0afcb5ac1778471458e7611c61d372dd99b256b3a13::points {
    struct POINTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: POINTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POINTS>(arg0, 9, b"POINTS", b"RainbowMantaLineaBlastMarginfiWetQuntPoints", b"Choose 18/7 work. Choose no airdrop. Choose locking your ethereum forever. Choose burning money for free. Choose mental breakout. Choose POINTS.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://files.oaiusercontent.com/file-GaVM09z2VU1lHqwB5oJDz8oV?se=2023-12-15T07%3A49%3A50Z&sp=r&sv=2021-08-06&sr=b&rscc=max-age%3D31536000%2C%20immutable&rscd=attachment%3B%20filename%3D3b9b79bd-79b7-42f0-ae19-7727ad4c352f.webp&sig=V9UVvVswt5GgxgG3KiiD5V6IvM83WOR/NR6Hbj7pnXc%3D")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<POINTS>(&mut v2, 99999999000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POINTS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POINTS>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x2ef73b677f5bc4292726419a7998d93d0bc01eee0664198f7ba171c94b1aec44::UPTOBER {
    struct UPTOBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: UPTOBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = mint(arg0, arg1);
        revoke(v0, v1);
    }

    fun mint(arg0: UPTOBER, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::TreasuryCap<UPTOBER>, 0x2::coin::CoinMetadata<UPTOBER>) {
        let (v0, v1) = 0x2::coin::create_currency<UPTOBER>(arg0, 9, b"UPTOBER", b"UPTOBER", b"UPTOBER IS AROUND THE CORNER, ARE YOU PROPERLY POSITIONED?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRo4KAABXRUJQVlA4IIIKAABQLwCdASqAAIAAPpE+mEilo6KhKxdMwLASCWwAxJpGfsH4zdwKA/xn5AeypZ38Twhpp+6nJT6tP0n7AHjc+tnzN/r36yHo8/xnqEf2P/KdaT6DfSsf2X/v/tz7Sn//rde4egk/ueNf47ZQcsL9qo62605GugB4tOgH629hD9dutGwV5zCsm385UupcId3SxChDdjvh2h/8GTjStNL5WOaZlHAEW21U6x80bGmGE4x+EvzD1FjzdFYCA4QUDC8Ozwep8A4mxBzlbcpaiUgoAnccpDo0LseqBhnSQ8GuCk38KbXTmokoZmvV5i33PXZ7YM5u16k7LAhfZ9qtx6WqsFQHToa3Tkoj6vkHBfIJS3Ltf4YDW0lGRIp7Y59Tx8alEKkq1XwVS9eRd74+aJaHtSkZvG7Zl5rRHw964cPJt4bh6B5l7XRzdMJX7iRzTO2PbpIjGdYrmiH8f3wP4Vq93P9DmCtopC0q7W/MI495rhzcygwziATdTFqi9xM8+Mcy+ma0R1gA/jEx2jmD7v2LL7Fl77PM1BOeWQfFuNkmOnyps/bHNQyb0kBUjhDBl9HXWFu3fMpGek//sZ+pAP87mDqwcC39xYnkv2WCSjgAgjV6Qr0s6ro9RH2zc6vtlzQc/xvCGXeI0D8bKbE7N2p7yI37p6BwRHMU4/oasVeXI+ZnbPXkff3/z4Dkq17jvjQU69qlh6bdtnAp+e5zUXGW2hBGxtbXePm3lGqF9V6mGP/0eZ8PXTNYHf/bA3HYwKYkumy2OKIXJVg8p/pEOh7B6D/BLirZpl4/MSRvd77eTklYLRZnl1+Drv/vV5P3vvDV+vW+mQMTktYOtmzE4YHNzdMQAseth25fKLQEQRlpnBfFMT5s4r+TG2W7WOmjgVbLpkxP6nW3LJ/2goaWJOvkv2Ytb/1wnwyaT7A6UwIGS0y1BnISgVFB8dXjeM3lbzlP+ZAFmY31B2PVumvd/jd8K0UrSEP2hgAwI2d02QBPFGINv9o2LjsnXzD6bL9IBcW1/4mI2nf2Hgz4t7+iX8OgP6t8n+s11cS3RdnQ/0UreacoC1x9oc4mWDAqu1wjVetLUlBE8BmEaLvu1bUyp8jcIx6zVe+z23wAnud1GmFdyMMxVPkF9jzGFQd5StX1jEZWyuynIGhnTIiZly46ClNVqjvYpGl5xMGNHbmCEKahDmiwez5fbZenwiyzJ/YqEQe4z1Ges8ZRDn82shUlNmtxrBRKGdgERxNB2z1mKxPP9frFR0epvFKlNzUAtBtQba16HX+8na8KkZrfWnx26Fb2wv2mL4MgHH45ZreG+wj+iWA4+PXu5p2D/+GsFPkT0+Nth7HRIBemylmlzaXDuNnzcy0hE8RfWzx/FTeWM//fmhQawUwVKSZuxuXuq/4i87FentP2lDDjXC3SfHaXYfx7g1JO/Sim1THvEsCfmPNa/DjGuzSN3XhHTFINzLCSOMx/XQkf1WJilk+qKd3O7Sfjz65EXiSfXcOKZJ029WHaOPBSK9hHkVwsURgnHN+vEYIOV/fNbVUn+o7BWtqzHHSRMfgkwNufK5/yBJ9uYsfa4GxjeFDD89uEy8nlk9Fw5vA/0h+9h3N+UT0p+8r7+yQ9Yavs6WxCvKen7pEu0Tokzg4lKpIH4zrCdFBFrBMvuQnxT2zPF53I8A0mymLkVxQiSf1l58WNvqBHTWvOjwdllaODaAOQTZdgoLG/5jIDk8AwSuMubwYBtFRH/58sYhyHPj/DalpfWCX1EkWzg3eTqevBehAbvFZIABJmeU0r+IriuCW/4nL5l8B3wz9unJg1B2YrdbF6ucTRcDe/Q1RsKAo2w1DBNJSzhAptjuWTsSGJXd6ZXMvVpcsmX5sV81Zr8gC8FDu7paTyeeyb86Dx02eDJWvG6J9ME/QmjrqMzPEJKoxy0XkMfjuS33zPWUqKEDs7irdIBDp3cyqDFdL7pWjy4bRj8K9LnE7F9AwhZXAvTlhTjn4cwYQuISXZO9LqbVDBxI2+OhbO7vwjSfeHIEh6P+i0tM+aYV4Jp1BdsuyYH94TiFl5cuJxZ9a2r/RGDsn4Dk/9EYBPFR8Zg4+VV0kMIuXhtRTC038v+p97reIdurz8EPU8tFaYiAivhHFN9v0i9jzxETYIcfo2jxpsuBVw/Thuj+13+lHWZjVWm7gjveRtow/PSSsDAaEdjkkPDM6Mn1A4Ja7icOEZpkJJvqybYEO2JWksGeag+i2+2quq4ZfPaCYtTO/l1WiH678QCNHfIUJjDlprof8ib6HEsME+tfbhCGA+b0RAfrcAyHZ/ogVpH7dzXqlkAREeVjipzGNE/a1ZkoHghTKsIvCZHpMxwk7nYP8IzwdtisTs7OqhAtGQ5Kh8A6RE3FwxgAtSwprkC7rwdZAjUEN9KpBO4FYM/B3EVSunxHs2JRh2SUXPcsiVDZo4pr75LQ/noofUiZOnNT27GyrdBK9g7eKfgOFjUzRTicqwwpNxrx//fPkftW52fFy+VsG8uHfB1kWlYpggE89uGEMslPnHR2Kd+YvEQ5rnnP1/LDXomUT3mDHURCIzPp5WVPgkk7CWo6IPI7iNOc/1d27jii4QLqdYVauK3RCRmlN384UwNFzbCkBlXO7bJCBVBz/7/d9B8e8q25/3LZmBqC0188xXf/bATv1ETTZR4T7QliKC4VdHN+8t8JCIqhvL3c9xFl+ug+bPEE1TnPKrHA9uD5pzQUqyhswFD39VDBTKj2omC/GgdKr1nTiVp7suNC2Qd6Gc3uddcnXIvk0Hiz9a1jDM10477fghouSLLKlj9e9V/NNi+aJ//5pmLmatvzKvdDLjy9m3rBUORF5cOWKCrqmgKnAWiDzsSzslUdo9Y+XSnSUg/DCTWJK/I6wruCAXeJHPetBA4eeG/m10EnDzCgiXRUoiA3PRD4tR8RFIZvdJnta8wZZwTnA/Sqm3b1p3d2AzO8TEiC3WQnJX4Ho1IT8i02XW5fmOe78E391LbWc1Axyh3mPUvms//qmXc0aElm0n9Q0TGIW0oVpbSOIXrEbtnBG3rTWjoYiGpeRttqwf2QMR+j+7CkyGrlaTLt03sEFCtTP7zu1Lb+fk3xeohzYTMN7qu1JoLLM+n1VBLPblt2gaLdQHk/dBmDmFLK/hJFLy1cKVnoMt8yvjC84W/Ostklhrj328opaIHEW6RbKEKyD9Bn5SKZOC/nQBOdkFjEgUupV1RcGEPsX8dQuUTglWYepFi/5qfZ1lJiMRrw9mXty+5yAW2mRCR6kf1UxixwV4nkoes3o7/ezDOlyjK7tSVr64bPkoMUvCd+I6xmgFBJk9n6GBbBZZWG8932xHp1vqRKzfMj5RnXYdP50MoHb+59QYMlBb2UcZ73yfeHI/Oof10asZI6u1CaUbbwOyy+EDcEE5K9Be7crIpqTpOSSpQ4iuoAoXg7OAOD15mP/WiCjqfh2uSDg3JR5IpYtj8cJNYWXSQ7ViMoxpJgnyguC34rK3RBngNRojPP9ONnq/Sx894TeMi0t6P8EsylpZhn+g/aN6mM/o4M4GphNLBiMvdTnA26nyM+SCvoF5TfN4vMDOu1SFsCfAAA==")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<UPTOBER>(&mut v2, 1000000000000000000, @0xfcf89d9dae5cb2177aab5442533320ca22153815d69259c666b5eee28613f050, arg1);
        (v2, v1)
    }

    fun revoke(arg0: 0x2::coin::TreasuryCap<UPTOBER>, arg1: 0x2::coin::CoinMetadata<UPTOBER>) {
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UPTOBER>>(arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<UPTOBER>>(arg0);
    }

    // decompiled from Move bytecode v6
}


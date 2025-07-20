module 0x1ac4b53dcb1db82f48aae2e0664caa973198d6dcbbc076731e0945c44d471439::ads {
    struct ADS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<ADS>(arg0, 6, b"ADS", b"ADS12", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRlwFAABXRUJQVlA4IFAFAADwIACdASqAAIAAPm02mEikIyKwJBYJSgANiWMGe9UAkANjfsr6IToHx29QG2U8wHm5eibecd6OyHmNAe9fffBg2hjf+OM/0fiQ0gU0bxufUW/zFuhmvwGwwLDhv6DCONk47Qq5ocj837+YOUAPIyMR/h/oNL2BJCB883BRPwYUle6xbjhN21wYHn64rKF0ZH3mfYcyaxrPXrQp4ah8YksId3Lio1annwi9vi5dt7Bg4JLQE84m1nh23CRyTOnbD9IvrXuT7DBXFn3xpRCiO9ewJ+H5xn/Zd5YzuB2yudC+9coSRDJ4VYXCZUczijMQV09rERhMfffgdsfqeNWI6LnikeyZPgEpbTvUXPcwXnPYAAD9+0UJM/4IJd8g3v/jeLx7xxdcWvKoTB8O8TgAfsF2PeWB2f38NH4atwzkokfcMGyMKNyHz8o9/JjUKO6M8uVkpsj2FhoPBLGNJqQggA+5wT3j5g9vG+Gw8Oiz/f42d/CfOldJ/LI2fRii8Go1UNyK4yHcW1U1gyw0FhaGIxvPj2R9W72HM2zEXP0FDdydUr0TULWv+eZ/+up5ByNY4SS9CbZ1FErwCjjb3WcNhxNJUBA0eerwPGx/aUcWmoDE96tocdnIWLwRAlGpzytrD/pLoaxf2u4XggtuBgoS03j9tN/wYukRUOvYX8UP22jfXOHgd3P9fw+OcPh3+u4uvpjf+zvsHxvxcG36dzC+GugOzVb/M8HBt6zqmPEe5OvqqT/qwOgBiSnTiqeW93SmHVFPiz+oSJ8sCqNacy++WkW4qTtzMv7mteSzvWlspwv5EcP/kwoSh2IX+dmu4FlpxeB77ysA14wgL62bQKiWU8Eb3E2/KTFr4H92vGB/clLkH5r8I0VrDD92r+p8Wxib2XKPPLll+5uNZwQp8i3uol7QTRhnd40uD9+D8rF47/6O/7AXGj4p/85P+xF39pg3pG//2AypiKQa9OL/1/ELpwb2eT/Oa3GjqcnCA1qBSLmjB4edBx98FjE7kwOUWSMSB3fnGMK+DW0jDh87dgu9xnf+cag648dmxPhfEW8rXMmWpV7NMJXBFkMVz5ZD/Q+8yF+8untMygkiz/iAotnAk9T4CeywQvNljqih9sZzSGHB+XkES4m63wy4jAWU9tqpLmitd/DWHmfRXFAqr3b9N9Bal1UY/C3i+je8JiQ30PF278DitsNfnimlOLOWJJOOQB9f9wFjEy/lhd1HOb4NUI9ZGtWCHppl2cnHzXlEbSWOwyUPYPeTQb9Ycyj6r75vEWGhixidgkysTPT0BGMH/6CZ/YaanCWlsRCGKLtsp7jEzX+ZjPEiTs+11HO8wW15VN0AwHTPc/F5Zzp28lSh/SJxqPMg+xppgc4nrf+Or/w7h10UyLCSCQiBNgnnfmJk6hSOMYtk4O7ywHsyab/89/51L7huB9bEIn0dDt1f1AH8miKr3PdFSrvz0pPQCywsAquIWnQEMz3WpaGSAzMRU39j2ztOVA/6K64btf03Hs8l/BV0Jl+2Fm2FLnuVnRd2na0G7nmmL38rcGl7eOPdLcO/YTXfvCcNtRH1vBmN316tmiWS9Z9ARsCIxrUP0hUIsfJonueJ3P5Ma2/nNF5F9ki7BOp2g7RtqVX3CV5soTCJwNALBH16W6HHIj3H/0gW9bhZ62EmoGObSj9v0X7cJBHg9hvUO+Jsx7v0HvIWtBbr4wn5d4ynrHc2onvnrdsmBBuK0IcOOTPNAJDMEWxkOTUlhK3y1FPvKDa5d5A8a+DzaPo/yaxvRJeESrW/A3do/21VTTHqIZMXAfCBVUK8qfQA"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ADS>>(v1);
    }

    // decompiled from Move bytecode v6
}


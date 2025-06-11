module 0xb8f01ec84dbafb2a1154bac1dee47567d756cf948f63d83595459594c51f9e28::mag_sui {
    struct MAG_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAG_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAG_SUI>(arg0, 9, b"magSUI", b"Magenta Staked SUI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRvwDAABXRUJQVlA4IPADAAAwIACdASqAAIAAPmEqj0W/oqGa/l1l+AYEswGMAfoAh+aA/t3bBZx53+TH5d/NJX37R+N+g/ar6XnG3+m+6D3T/4fpB/73/DfX/6JfMB///T/8//1AP//6IP+P/+W/N/+f/S/C9/tPV0/4f8z1TTwp/K/w87YH4c6H+f6gDxNI7UxbcGFl9vCkn9NLtBDEb4TynGUppGk4H4w8zHp2WJY+88AazK9knmbaRGuh00l9LDRQE4aki6Zb8B1iTYg4/l9DNte7cCfr+z5jJrufAlbOEr2BquDpXJf2/wHN8WVqDDJpwoyQ5uVN58QRmWSW2tt4VOZU8wywkf9cs/bIfBQZIyrK0OO/4bTx8AD++yPcTu2R6RlBxnTMMptWfs26EwIe9OULnrNIzRALnzkfKU7tzDNL1+wAeq0x0hNpaGRZWSpQCiT+3WecdcL1l9IZbyX0B3XHg5an3oHmmIWFdj4NdTEaDZckJ2DS7MvtryHacMFY29uvxnL/Laopt2w0vA/XyVH6EFsUNuB9LhQSpJqwJb9GqbCnwNOvAKXgh38V+GFxtNTJ7Y/xp/yf083+jXWsKovAfOLFMZjZrtZsgJNxste+XEFlzBUR7W62t/mHQXfsgsxA9+sj43evcI75lrRHpMMz9oozEhXmvZpQPl8RioO6ji+SQcJsAHY2vS2qqfGefnHddwXPe//u3x9xOCmAVBfza0Aj7HET2mvydy0+/7mzIc3//bbv/Hl2NINuAG39tkkTfYh/Nbtc+mtsxdi8PYdBk/S6roP/UF8pbuvPArtJ6vZ4EpH2WMBTZ70b26XYAEmQsMWnC1LGgXHHgTVrNueSZ8apeMwSpNZKxvxfqhr68ir7p3jB8/a8Bl5Mmgq2hOM4kB1RbO9t/Ktdv5Q2CBCOgh0SDKoDiwNWsrDUdQvlJ7qXfEgWbk7LU+OlbVVBlYrGT889jjU1u1DpGbLaqc+mZwNPVrTOQVBPV0ZK/YD/XgCDSMeoLfEkCLSnR9Z6IjxCP+rdG4swG/liyrgwkzyEGOQP3kpk9BQh+lOtU5xLs9ivaxNKK8vOdv+0Er+rFlZdRLaKP5DshJyEWEwQRWK5PBwueqrrTMWvPQp74vGOr7ZVmnTRHuUzfdCCbCpmmTEtQrpRx5NaB2HdlfKNIa4Ynv/MsbzjiuoOpXd+5716ZNFvhgwuV2xj1k74QMg1pmWrRV/vM/VT089JZKwMgdqFM7/4pOQw1sJQAyYd/YburO2aQFPQVuqi8fFLD2XBmm33vZuVB5af7t6KmYTjY5NbY6rz0wYIiVtE47X7TBZkP8h9u7duNKiCOwxO3kWwF00/gNZjdez3L/4AAAA=")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAG_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAG_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}


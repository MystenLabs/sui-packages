module 0xdfe175720cb087f967694c1ce7e881ed835be73e8821e161c351f4cea24a0f20::satlbtc {
    struct SATLBTC has drop {
        dummy_field: bool,
    }

    fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let v0 = if (b"data:image/webp;base64,UklGRogDAABXRUJQVlA4WAoAAAAQAAAAPwAAPwAAQUxQSJoBAAABgJr9/9Po94/ClmsLhKwAmYCbBHBIJriOx0dmgKIi2wi9uiY7ye8q5f/N+Yhw5LaRI0kzs/HYwe4nUEaFZnpRc7A5MB82g2bkmpogeQrdDturmBONl63Q1iV9UTCC7o4zuesGRkHCP4pP4wtn9jJ5LoqcaH6fc9r31VzfWo2YcxvXzexfKs6CpbhwlIyo4ZYluQ3VTDxUzizNc+Uhy11lqVbTL7XCkq2k/ah8nGVzDpVk3C1Ld+skYs0Z4LycNNprDLGu/cWPMcT+H4weg+wZv2fbM8N8Ej+UxjhGv14CBhp8o3eRdHQie4tkaxOFDDUkvYWlpVtLLEvLi7HEXsRgoyaa5gBNf4Nmc0Bz4H8v/gP+LwM0A/y4xc8b/LzFrxv4dQu+bsLX7UcivYOkq1/BvkVkjHCMS0RE4gnHs4DnhmvJLaTVMdQ0+msZk9ssStJB5EY3JbeG8nPrhwLPzfDcDu8N8N6C701ZFWZdRm9rWIJyqMrojVru3vo8ydNbx09Fge7N8np7K7W3r9qZe3uOcwM3+dzAy35uQFZQOCDIAQAAsAoAnQEqQABAAD6dPptJNCunJjAUDACwE4ljAM0N3i2MKNY+29Yc0CqvSYK0SpMxOMPAF3xL8Y59jg2ID9HPRbpe6uZpprOMHuzxoSuvxJKv8VZI95Nt/F6p0tmp2AD+/dtHFHpoKitlt9Q8f0mZUF8jwPRZ2PaZdQv5Cx5Y/NOsRn+TKZ243X6OOuGyKXk5NE9zrrn7d5Yd4rawn1ClQ6qojXMLkZBd+CTntW/TQJYJiea6Jbvrn2mq2jSjTRjMn6CR94FW7/WcM0nYAAD5VlGnuzyXJ3RTpruQzt7sPq2c9sTlY7DMmj+13dFmezi0YEHXUh7Mk019atDYy2Q5uiLPQFakj7KQHACodeMG6WGIjcefkmasrLidBXr6jz+lRvgHKlNlY9NWvHI3SfIw72dzMfs4ZvI4qL6ilKAPl9gR1VQ1F5earGvDUNJZffp28G/HzfObqdtbDis/ay/008pFfgHsd9ognfybZIdSvrsWHsyu52Q98kFlJm7PBpBmq9R7UOuC30X0dvLb1868BTUW7T5XJejAtA3/BwkD63icjQ5pvkWQe/JP8b1Zlxq2m+f3B2WKRGVaEYw0lfze/7GVcddNvaAA" == b"") {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRogDAABXRUJQVlA4WAoAAAAQAAAAPwAAPwAAQUxQSJoBAAABgJr9/9Po94/ClmsLhKwAmYCbBHBIJriOx0dmgKIi2wi9uiY7ye8q5f/N+Yhw5LaRI0kzs/HYwe4nUEaFZnpRc7A5MB82g2bkmpogeQrdDturmBONl63Q1iV9UTCC7o4zuesGRkHCP4pP4wtn9jJ5LoqcaH6fc9r31VzfWo2YcxvXzexfKs6CpbhwlIyo4ZYluQ3VTDxUzizNc+Uhy11lqVbTL7XCkq2k/ah8nGVzDpVk3C1Ld+skYs0Z4LycNNprDLGu/cWPMcT+H4weg+wZv2fbM8N8Ej+UxjhGv14CBhp8o3eRdHQie4tkaxOFDDUkvYWlpVtLLEvLi7HEXsRgoyaa5gBNf4Nmc0Bz4H8v/gP+LwM0A/y4xc8b/LzFrxv4dQu+bsLX7UcivYOkq1/BvkVkjHCMS0RE4gnHs4DnhmvJLaTVMdQ0+msZk9ssStJB5EY3JbeG8nPrhwLPzfDcDu8N8N6C701ZFWZdRm9rWIJyqMrojVru3vo8ydNbx09Fge7N8np7K7W3r9qZe3uOcwM3+dzAy35uQFZQOCDIAQAAsAoAnQEqQABAAD6dPptJNCunJjAUDACwE4ljAM0N3i2MKNY+29Yc0CqvSYK0SpMxOMPAF3xL8Y59jg2ID9HPRbpe6uZpprOMHuzxoSuvxJKv8VZI95Nt/F6p0tmp2AD+/dtHFHpoKitlt9Q8f0mZUF8jwPRZ2PaZdQv5Cx5Y/NOsRn+TKZ243X6OOuGyKXk5NE9zrrn7d5Yd4rawn1ClQ6qojXMLkZBd+CTntW/TQJYJiea6Jbvrn2mq2jSjTRjMn6CR94FW7/WcM0nYAAD5VlGnuzyXJ3RTpruQzt7sPq2c9sTlY7DMmj+13dFmezi0YEHXUh7Mk019atDYy2Q5uiLPQFakj7KQHACodeMG6WGIjcefkmasrLidBXr6jz+lRvgHKlNlY9NWvHI3SfIw72dzMfs4ZvI4qL6ilKAPl9gR1VQ1F5earGvDUNJZffp28G/HzfObqdtbDis/ay/008pFfgHsd9ognfybZIdSvrsWHsyu52Q98kFlJm7PBpBmq9R7UOuC30X0dvLb1868BTUW7T5XJejAtA3/BwkD63icjQ5pvkWQe/JP8b1Zlxq2m+f3B2WKRGVaEYw0lfze/7GVcddNvaAA"))
        };
        let (v1, v2) = 0x2::coin::create_currency<T0>(arg0, 8, b"SATLBTC", b"satLBTC", b"SatLayer LBTC", v0, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v2);
        v1
    }

    fun init(arg0: SATLBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_currency<SATLBTC>(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SATLBTC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}


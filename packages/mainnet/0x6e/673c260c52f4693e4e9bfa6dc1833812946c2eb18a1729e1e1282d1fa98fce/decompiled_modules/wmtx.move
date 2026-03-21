module 0x6e673c260c52f4693e4e9bfa6dc1833812946c2eb18a1729e1e1282d1fa98fce::wmtx {
    struct WMTX has drop {
        dummy_field: bool,
    }

    fun init(arg0: WMTX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<WMTX>(arg0, 6, b"WMTX", b"WorldMobile Token", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRo4FAABXRUJQVlA4IIIFAACwGgCdASqAAIAAPm0ylkckIyIhKhc46IANiUAPGn7v+RHMq8h94+ORP91nfkvtV7TniZ9J7zG/s5+t3Uq+wB+p/XFegV5YH7Y/CH+0v7Xe1JmqXXv/Xa6v8m8QO1NuusDPrdrH3innw9AnOk9Nkkow7mFRh3KI/fSg/sk/eqZRZMX5XlGNaranhFhAaojUlpL0UUSyINqTVz23n7KeW20YR/uSciY+02iweefAXC13ARiz58weD/cHKSZUP8pWgcadgJ/o07PybR56yj3lYTeDseJHQ3HjLxYWTuYU+gAA/vytEAC70VM/JJ45l7dSMXI3xlpMqeph17nBCYeDxnY/y2/xCN3xKaSLsCTKpFj8G4Tn4oxjgd+7SeM7gBX5SQfo2ro4IeKfRVHXBRw0TD6rJC9RvUY6scoMX+EnyuC+Jh+H9sP6QLXN2JqYKsHt7hqO0MxkzFmy8py1lrbP4KUZ45llZF+uJMDUWFTujszBec1Xwv+2fxcVui+7t6OA96SKRhksHl0sAukP6dJwGmNXxEZpw/va32vdUnkrsD44yw5600cFgXiqGuaUBNIvJSQwt3DpE+mi87PbOc2h2a7VVnOw5DvHPDN0sAnFPTGbDHJmr1a+CivoY9+Q0J8/9oUKI/pR2gZEwhxmSoeOuy/5S96PVgDWTtGt+dUuCcBr8C7CiHlHc+FEwuGgvAzf4uO3CigcZWoCvn4lqWV1DG1Q/BC+RWX0yh8fB4GhxKDyNa8cm5980ZyykBvYBCB0X7JfcmORTC1nf/o4rSQzCBiS7BaDl+1GPV32VuP+JK/udQI1cWipygn+TlkI2AqfH6eE09cBXGkUQsNOlwh7QyHEDuobl3Sks1mmWHLoo3LIlHIR6NHM4N6FCG19MG6mHSy0hbhMvYUQka8ZxqO44MlcYJ/4UrI9s86XX4jfg/izWZX4LsYKaPYZN5NtHZoFdUwmMSQec/Ud6/eRXmYqIu9r4sXyfyd21Z5qHgxxPrzc6HI0uQANKF2eSCnOQkVfCPnEEl5CWvUGB041kGZ0F5etsRdgibv7Tem4/S5vsz4HLQLf+7Io3nrsz2GovnhSOAGv61sQp26M+w+KeopQGsJ/dwXSVkz1ZS4iTjJzwdmmvtU4NAP9pMBiZW1mr6lsa3CmEzh7Vt2mUu+36c6PJZBxiyt2/j0JzZ4/3tP8rd/gKC7XDL0EIqh+s4n8lccq210M2MufBM/jwXUI47cUeBeb2eYGudWhB1qBXc04A/6DgTPYGWGa9ljVTAlE+Ke3tTPBLJyVCw5K3xDYnrk2P0el8psZKozVZAA7wp9Bm92afqS3OHAG+Z3HCHBZ+Jr9ROhvg72rQaTDxhKru+/umC4AmsIjgBXXZ9xX2Cb1ke7WcTUzSPky1KWogq53va71q257/iIgXqJ936otDjXxgeIG/8TBbN0K3J237A7uxQ8BUuvkABGAVK1tOTSv//XgmTm7deP+/NI7PlzUqveNePcKuO8VK1/AdCWryIDB++HGDRtYeA1igDJ8gh5iEEaDbIopClgs/8De16pT/D9PCo3xt3WapoqjUWIQbKm4bfQ6W3JH01rRgvVtflVA0O4eEb9gyOPvaRHy2EMINli8AoCt/AwWkKPZts7/G+0hnTOC2O1ATMXl9FsIYXe86Eh/nlreAS7m982hD6W9gFYM+wyUz+R4Ib1ccBj/5UpQ0SCFm7rgdvG12/xjvXQubkiX5D0Q880HqeAdNUAY3Gkj0+tU46NMlMdOHgjfw1LnEfmGMoLgszlVN/ee1L2BMXZFz1QaDK0Inz2sUMre6yor+Yri64EsN5B6ilu1JJtjmmggrrg6rwaTFS4Kf2GAaCMASqgi0z6OmF0ADQfiSwX2AAAAAAA="), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WMTX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WMTX>>(v1);
    }

    // decompiled from Move bytecode v6
}


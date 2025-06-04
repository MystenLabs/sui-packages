module 0xa8402a250b259d48bd8c3cdc5e2ac237880548d5598bb32ab5cf9f89406498f1::g_sui {
    struct G_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: G_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<G_SUI>(arg0, 9, b"gSUI", b"Go Staked SUI", b"High performance liquid staking on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRpQCAABXRUJQVlA4IIgCAADwEgCdASqAAIAAPm0ylkakIyIhLpRoOIANiWkEP3M1ju+Gze1vsB9AHhJ3gjFPEBpApl/id+pvYA6Ff7Z+zEUppmZWXiZNygkk53xm4qFp2g3PwBuQQLLdhbqx2kyUM1yUttt7/yEXXLP7imUB/+UmGWLw+j1DmHArOJ27pRqQbLxxoa3NKzqbcLFAr3Ww4oh1eVDvOTwzqbPQodBrIwAAAP77Qmqy4N9zKh+kh7gyNoFAMVdvDNDsTb/Gz/wIzN8/qaHZl8I6A3Ni0HnMF1uyqWI1e+Q8BxHJzAUl/zQWf7P99BFqVTW6UreLNWKgTLJm7YFS3JtJmF6v0TOQWWCVw81ZADPykp9r5F5NCWvzr58O4jeJqVCGVAv+qXcSu/zRWVyq+F/O1b/ctv07SnWI5WIqLy/+NWTvpv3AGLARe4xG0FT5WIwZFf/73Yq7Qd6S6hwx1aDLMs2K562UKg2vGa07vq88bTl1ZcnIoM/9/ye4S80c2nwULXaFY2IYQhh+XgGYCVRUdf/v+GZSu22Ke6m8AGtm9zFrMVxgZzX2SnNFbnFqSUibnKfyLn3yVUibEh73w+Jg0m9GGcQo+8HxRmAO2AkjxQvPASy4ohM78sRfy4XSPa93UEAMfwGpwb2NFDBg7AAjuO+spPWvWFFG5zoa10WgNJpRs1sS9XlgL7LSannMGpeWQJbl/TJm5R0gwTJjSPyeOYTTOXWdLwFUVRn/b8Au9gDFDZ7cEeX8p14Sm/ikjJfbHqWN7OWh7VQ12rPX2Up4Wus18dwVtuJxDdcExgv/zrNn6dajygrg3A5Sg9AORLQV55/+MceWYL4fUigZwL3tKYN84FfFbibsYXRxCC+AAAA=")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<G_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<G_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}


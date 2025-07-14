module 0x6d5b7329907cf0d6cca4818f4b6d40d7b40d50d085fc75a87da18b22c51bbb1a::pop {
    struct POP has drop {
        dummy_field: bool,
    }

    fun init(arg0: POP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<POP>(arg0, 6, b"POP", b"pop", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRmAEAABXRUJQVlA4WAoAAAAQAAAAfwAAfwAAQUxQSBcAAAABDzD/ERGCTNom/k33m4NBRP8ngGb+HgBWUDggIgQAAFAZAJ0BKoAAgAA+bTKTRqQjIaEqFzuggA2JQBC+C5vi/OLrX8+/DXKGnm6vP332jdsvxUemJ5l+iJ6B/7O9aB6Gflq+yH+437d+1Un3UF5uZiwN3JA0DV5yaFa7C1EbV4YHfWyzLR27tnTYNR2zszXmhAMfQTpuQOzfnLfINlpApylUzPYOjmrDKD/I9ymyH1e09pAenaZqA8SoJfxZ2OksRWmGuGjg7d6RE+dWnvJoozHIa67lVpULFoEVQj/hM4JUNdHmBCg3+0OVD3HvIOVFOcAA/v03Lf+x0GJSBaExmwFugb0A65YYu0tfuGvs73jx6rCV/P//CuUKcRmzkD3NyCLyfPCG5VLwm/bfP/+tsioN1SuFVh8fpP3FkGFlPSHiadd8mTa50BDYjenorXUYZXHF/+tAcAnDoqNOGE2n/yH+cLiPKX32ZMLPzaAvMNUt7sl0w+SzTw5kG0Hg23dEUbzOEn/8cexjBWAwuJKKte7URqC1SDCeMh9qRqnCqT9b8Zof55rUnwOYC993MSPKHmO1Fu6FuNGWNMVjRkaW+Hl3gNrDRv9dHOHDIX4penzCoWzfmRtKXeYBL7x/JYpCYQiCASKpi1Vrxk8W4UjVLXKhOmKIfnEaYiNvh2UG36UQiysHIyxhNSIY3+8th7OsH7fIxRlCXX/D5DWFGRopxnCBarxPYiPen9MqmKFe8dLdHECcXjNZyNjtArrguTlq4FVvh5d9wAnj623R2XZGPtRsBcpk9Wz6PcHFyE5FjLZb5X1zoLDDjC+0rkAneGWIReY3owosD70l+z7Py4XAl6GWcUUN9o6TaQV7I1Y/9gqmtFwVfo8Vjmb0579onHX+5QqaauCvkxCXQ84NC1K3CocNAkP8uRqy4wZaJejN8z+xT0JAoHlnS105HisE1PAccFMKANgaZVVul+59R6snKuP8HINh3/4OkChzaN8g9DXck2G55FP5IpjcjWzmjeeLm9aAx6HOmjoAd0f2AN5W0OWrD0fKV3wt4DpKkdtgWqEqXszfvzOfB0CB4AUv/Bkpi2lXWva6nRu/9kjrM7VWD+uG5ktpTbMFAQ9TvL1aOsi0E0fCfkW412hMC9PfvcmYwZYeUUAgF6h9Z/bLVb2+/8vGKKD3DkRwu3v+FiDZfoqtVuxBbhu+HOG3OoTOvXumReacgNttIDZhJmfHh5pt8t3VaolYJ3AhuZpTnJJamVVLkKIYLN0+qZre0m2KIv7CqB8K4RC1WoPQHNzD+j7Tztrq/CbyfAbJ223/fe+3MIN1wIIw9WtX7Gc45rRz7hHzyRBkJ7ppOoc8l4AB16pzuJAVX/37+X/183rKEXUbiBfX2EZHd9yJ/8KYBYP/XPzv5zCODPbSzP5+5BlWrYScgrwfsfmu90tKS++AXueAAAAA"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POP>>(v1);
    }

    // decompiled from Move bytecode v6
}


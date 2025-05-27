module 0xbb771002165f877764862b230963d0a8f2203abc571662b6a81105540e6427db::liq_sui {
    struct LIQ_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIQ_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIQ_SUI>(arg0, 9, b"liqSUI", b"Liquid Staked SUI", b"Free flowing liquid sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRtYBAABXRUJQVlA4WAoAAAAQAAAAfwAAfwAAQUxQSBUAAAABDzD/EREahASE/6dFC5SI/qe7JwEAVlA4IJoBAABQDACdASqAAIAAPm02mUkkIyKhJBgIAIANiWlu4XSRj2/0mug/vWSkzi5xg0SH+Z9P3Pv8uhUzSRi6GkjF0ImyajpOPNYw5ZYp8Ddw7M7+Gjq4ClXgfYFVxciDIRf/95mrU4D7KiIfYmkimAD+/1nDNVU9x0VIEJmn1/xYliUAwu23tIUn7+2eLZgXIw5QKLDKKhzA2aEhz2YMVlvY/lX3JkM8JHJ7vibkL9Offwn7vlnqUXDR8uHUX/hTgzNv+en/gJODq0NAoIz2ivokm9dKILmMkPKFgAFlenCVgBhMavU4fI3diuPp8S7J/58W9053AQkF+cvM/FJHt6/Ueu0LdJqcqYCAUr95RdR/oqQxHSwYhgvr+HRtfFu/ts85uBOx/Xe9O1ttpLzn9ybK9wh/YUm7OCdnH8vPJoG2B//uHW8eH/KXkuMWPyX9vU2Q1jGCu+seezqAkBF+8TjZb8PKftFI23HCv54GofXiM9kRsYp9WN6H1dq3OjxFvQBQxTsSEmZoXgMoncX9f6+qWFmf9QPg8ZjDAAAAAA==")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIQ_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIQ_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}


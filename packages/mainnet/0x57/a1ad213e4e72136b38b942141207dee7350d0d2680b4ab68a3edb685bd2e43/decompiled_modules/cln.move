module 0x57a1ad213e4e72136b38b942141207dee7350d0d2680b4ab68a3edb685bd2e43::cln {
    struct CLN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<CLN>(arg0, 6, b"CLN", b"CLEAN", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRi4EAABXRUJQVlA4WAoAAAAQAAAAfwAAfwAAQUxQSBUAAAABDzD/ERFCLJjkL53Droj+Z9znEXcAVlA4IPIDAACwFgCdASqAAIAAPm00k0ekIyGhKBn5WIANiWNu3/WDIBZfzlPADW0l6OzR6E9hm6WvTM/1m9gDyzPYp/xX+8cfeME2geRirApCL9E8Abqj9OfWP/t/ZQ/k/Gt9L+wL0aicXG6q784bdUsayt9aLJ7UO9XHhbP+jkr/eIEj+jVhziX8RdTyyrQavYcl/qK9TcHNvBMOdkfdGoGHGJBw2eHEY8tK2oevOV2NBv8UIxLVOYjxMdJbQe5H5w26q76wAP79NmgAE128w/rKQKEFF0Bf4SC/wZcliuME8azl0WIuN1EqKsIpCCB8/QSb1n3eg+Mf8+GKDKd82CPvVz0sYI4SF8JPwwZblPo9gG0oIF554+LAifco9k82//+Jhh7CeZ+1o1D36/8/tfs/+dBjgff/k3/Qj9/jwI5H6vatygBD4Re79+RMe4X93Mxb4yGpXnCryeR3GdXg2KQgow4GBCgbMqV7FUFUjwcNbU2wLwqrf5HaaZtj7wiSjK1QEh2kpImMvi6OwC14F9MmBjJ98f85/bBK/YW3mUGxuI8WWXA1s21yjV2lNTcTbROTEKgHNKJV9mYsbSua11bwyOmGy1xxe8PRlrUYFfDpNGgc4TI+hXYRt8uyCxKF5STGmjsS5ZidHQLPqr5Jm96khlPn3IpwEmhPWC1EpjvdUyHwunmZPe4W1VVi0SOnmXDL7T5035vJc2ihRg+86nz+KDhPk6Vh+lUlVQkDqFixA+rApBrC8lC7xQ3piZdIfzSDDCsTsFSBwu7J7VDx2Y/3D0Mwm7OjLWD35O2TZbW6uvuQsd4CHKnU04znxISfnilYTR1UZ/3UA0KALjWA9zm/XO4fO54qB0iYq3jyxZl6JPe5XqcxrwLx1rWxVv0fZR8ibb5Q+5GSX49U+jwcD7I0uHwJJGkpCcOPHxgLGPMrjIIApd/0mzgQp4A19xZKer4yUKspYzdhHpL1ZN88lyUdUNUjNArQyAmEPftARN6cBQdX+7PqTyoZZ6WpmBPNLxtH372Z6mv5xrHuadrCjfNIqGBkm2SrzTDopyvTdvOJ3i/n+u13p/+by+8hOL8AGlMtBCFGALzymJtAIYc04u/gma0XRCgp8eqZ+LqnnsCPXboU/6PF1FP9Vt29apdtVEdSuZPbYChZoX+3yG9q4zk7qb0vL8aUdB/4PxLn+IRlhlGzLH8eqP8lcAOtUl/m8AN0yhA3Hfs3vc4tZqSOrdpvO/7Lx48L2wRs+8XJEPFzUQko/AuI0/YZp63S7bw6TFus6l8r5IYyFc+ZfBM+A/5rr/ZRSnxvdcpo/y4jbT4VPHaAMCkzi3gv/CUwhRCeCexxDlQgAAAAAA=="), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLN>>(v1);
    }

    // decompiled from Move bytecode v6
}


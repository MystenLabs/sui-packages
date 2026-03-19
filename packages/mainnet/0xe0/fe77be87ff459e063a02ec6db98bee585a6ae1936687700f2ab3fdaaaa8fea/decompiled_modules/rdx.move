module 0xe0fe77be87ff459e063a02ec6db98bee585a6ae1936687700f2ab3fdaaaa8fea::rdx {
    struct RDX has drop {
        dummy_field: bool,
    }

    fun init(arg0: RDX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<RDX>(arg0, 6, b"RDX", b"Rdx", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRt4DAABXRUJQVlA4WAoAAAAQAAAAfwAAfwAAQUxQSBgAAAABDzD/ERFCTdsGTPmTLoR9RPQ/IZ/3D/lWUDggoAMAADAXAJ0BKoAAgAA+bTKVR6QjJyEqlJkg4A2JaQDUVva2StN8vqqi7Y82n4F6C9b/kkJHH6ExeOyUjigOo2sqHEFFoPHdWAGPfB4BUIBYRrWebflWEFqXznwsUs/YcmWCTlSwAC4iCskne6QIP+5wSe3vVHE1uy3XsrSga29+fRlCjs7reGhnpJHkwQWuIT+8/9ty9oLuSzRClQEutjqLm/Zc0Wa7LcgbEUKGorbGjykBn00FjYPW2tUmolL7v4sy+IGAAP78+EAHW0Jj+eJfZI71d4aX+Bj2v53Yp8So+lojpX4bOOh6cU2hv+3anIAibL1vl/VjWOx30MKV5NlmpPu9lLhxvt95o9ay8YxkykBLCPJS25I0MPG7S7hnBTHEqEh3Jd3b3LqaZt/ZAQ4krRnO6aHdoP3CR/EXb0Z8v4fY5eXxOqSxd/2xPh8U70UmZtGebfWR/lI7XI22pddUDvY9VgAXj/IBQ8gCMf6v+vn8CIo/uk+vt3wNNuMd0dqwXYC/8ZplGTamVH1K8r2P9sAL+g1ENJLtrGENxe5qoU3iX57JK/FaXCeM3sms7+/cgR6JmwVO+v6Q7W2Ocrae2X8zwbdJWrPHpqi2thEj+/EheBVXal3H6x90k8t06dg1OPSfxL8EZ99N8xlW6r35NHIk7o8Clo9CgG0PL7BN2jLcGM+9wVpru1RzrPKD0AshiPe0vwdC4TfjRCNyLPvTJllapovOvR3VNuv5k9NBxU/O1zjf5JnllfsFVYYHE/BYo566YTpfaDmS/CX+aHx2T5iuEyd11Phjc8+C44yDDaw/ZEHz/JxvY1DRnbbmvKNNaU8+04NKvCrKdkBx7/bZmcGljZP1JuFpcrcaTTxnhScYW9PRQAq1Tm5EEL9heb/6QJYP0k9fkqLQxg+18zNGGqMaemUN2Qdb3egBnft37nsTm2MNpM8F5PY6G/J8RxJOfH+wFgWHUQZ1dKZHOd1WNNcc300zrIzyb9WP7IGOUoZdxKFNVw1lzWtxS1vnHCIHbh2cZFazxoRnTJESZeI3hjn+Pvv5gyRo7wuld8PBbY1BaCmJI09FnKTKWw9/lD/dstUBwuuGz68m4XvzTxOx/eNtnL+XShwLwQ1haz0XSNcE7sLo2JKpCCLE/6dngNSzXB4W5JkigElWEVJnk8i4alpCLegRNmzDkgfEJf4O0vXAXex6ydy2ZDKXY9LoDRj0sJxIX0PF8jZSpKKiAAAAAAA="), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RDX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RDX>>(v1);
    }

    // decompiled from Move bytecode v6
}


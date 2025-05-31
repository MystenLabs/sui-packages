module 0x36baa09414785e1f8c29ceb94ecdee12ff1e4145ee8271228a57482cc70f640a::breast_sui {
    struct BREAST_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BREAST_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BREAST_SUI>(arg0, 9, b"breastSUI", b"Breast Staked SUI", b"Boob staked SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRgoEAABXRUJQVlA4WAoAAAAQAAAAfwAAfwAAQUxQSBYAAAABDzD/ERFCTEPoX9opgS2i/xOAkd8DVlA4IM4DAADQIACdASqAAIAAPm0wkkWkIyGXzGT4QAbEs7TVrd6LXVngesEdWtAAi3QgPGaI1uM3d6tYIwUbMQrmGbJp+Keesu7gfwCyDyN3ST12fb8riC9EyRX506d0HWZKtGcwcqjut9EeXIq+i8JNU7dUN37zFrnUU7DiZvxXX4HFRjR8zyc6XohpSiIHSyediJso6XMpPeABOYpxr2cVw2dZdA1Jwj9qRNtRShoyIh41Izr/GKHqbzea1W7TtzMesdFe+AN8w0HFZIYKcgk06ylkoMJ2fqGieg8ZDlE903ECfXQePjW0L1GwyXa5yrqigKuZ2yljcz/LB/enLs7qtlc6BJXHEemaYht9oMGTxqigyGiAAP7+zWvmqito0q2+pUWe+JOgSNoWPVvrtn0u/coeklCR/hGQ7OJkKj8YKPKsnxCG93ivIkdea7XFg9PsHb3C3adybk0Q0Y6h7FrDfzbQF/5DSUUEjTLt5FZeBzfpSdOBrt6pgtzwJ1G3EBpQNUieYwu/24IZQzui5Eac6CfYmuFnq1BD73cqr3kulNGnhCLB2pYR0Wa6CcviVi1ojxmXOlzRZU5r1FAi0lQDE5XMP2Czuspvhe9QeL3H1+m0oFraKanZCI4Cfg/b+gG5UEEuT/tYUGy8kbNVgjgibd8Q3zdbF9r+eAeONAiXZ3Si9wIZ8Ujj+5L5Llxr3oGIW7ixYoiNa0LrzfSp/5jcbVmL91/yKQmfpHPlWgBWEjRgawMgra31RSnFCEY/5vRx79ZXk+MvOca3i2I4L4GxjDnIjh2A6oCJ34MJd/lCi0rXP8YzlKLLpgOs/bvHfUQ72vnDjEAuwB1N0m0k1l7sr9rQ1Muc2eTgR4wCNSLRsVhPygAMoigAFdACAokLOI4zREevnmgcpJCSFXwh15Sn0V4HV3hn6IxJFPpeaVL2PvytkjyHEHwizYhWEqU1oH6rkgEbUy/ijyycunzSTnTgBcqZ9GyMRCXfgyqfQe23yJRNBoVdVtpzoJJUOJJgskTWcs4SR9PjoZ5EjI32RVasF3j3AahgEPRd7xpWGJ+f5tkV79lhuje/BXIubYk5IBZRJV03IkIyRn0JpwqVmRu1NIifK8nCbLQvV5wVZsbu28Rf8aww7cBjfDzkYjh+fEnrMQiEZAcDv5tfNLRTof1ZjgceAXa6uQ+9sg8G8G6AHw/ZYdUvvhhqH9IiblPFCYGEpLtH7yEec7AGfB1/vbHvU0O7MOT3KQ2pfus98EmtxkPk7dCC1XXrciKd5dJE0S1/Qc1L1QiiN1QySJgGuLsJGZSAAA==")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BREAST_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BREAST_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}


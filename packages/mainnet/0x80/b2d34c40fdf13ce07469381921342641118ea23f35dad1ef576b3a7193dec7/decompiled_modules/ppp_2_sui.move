module 0x80b2d34c40fdf13ce07469381921342641118ea23f35dad1ef576b3a7193dec7::ppp_2_sui {
    struct PPP_2_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPP_2_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PPP_2_SUI>(arg0, 9, b"ppp2SUI", b"ppp Staked SUI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRtQEAABXRUJQVlA4WAoAAAAQAAAAfwAAfwAAQUxQSBkAAAABDzD/ERFCTdsGTPiTDoaOI6L/SXzeD/EBAFZQOCCUBAAAcBcAnQEqgACAAD5tMpVIpCKiISUWaMCADYlnbt1eSk6Xgx6AHleexlXfH4jpDPFftRlO3y/CD778mH+R3my7Djf7jz/K8anG76CudJ6b9gr9WetZ6FAztlT0EJmfjepWu/92vwqwbHXZlDySbtfF9S5h6ett7gvoQA0b3k/hSENV4rcEkURyM40cy6RBg9jpV9M3NHRcKP4wUzb190I5Cym9ewquNaKrQ7dGsrV99h/dGfHnche4vjvQg4vsF1yqXjRsAAD+/PhADJh4/4XuesGEqzysxibOreQOTTvQl/+kC7jz4BFP3xEIfnAuYrH/23FH/lDJ/x3QxQdMsCbFCqsYOaRyBCST1dq1Y0pFC4n2aW8BSMBrAft6ZdyZuFPCvuhw2uoped7kIzxpfV2EGJcudaiDbd4vAPWge5jdx5u4noCgsKHpcr9wVb5b21XwrgAo2fae1/14rAi6bCS2XRfpYwIudrk+hErnFkI2ESES6mWnjYcrgKqZPuGRKMwh182Pw5wBoLY/iEMTP9E1wBlz8Hv+rJN231wgyPCLz88h+/PTk5pBfXQjQIgovXLUPSqA12hoSURxD+DhD7D+LW8+P3ZSV/k1f8Gmom6Y5NBF8TXx80dULvj6os4mE2PqS/JJqc9QnA7H6JljkUr1BZeVMjQMU5/NaqRUaX5UJLDL+C8H23wjbNwEYQ9kp5rwu7RTk2UxN8hGoSwXu+2On/SZVV3tYBp3cNvO/HWiVlZ9qqlqDl7NOOj/CIDdrq3aHI5SXiL+oygvh3L+9Ce/mf9rUsvci//6tx/8ncH/Gfmev/zgLOTM198R+r/fgMqZMbTCVwyf+Cij71YEuq5ksSe4Kxo+Pjy84/wRHHXC7L7fFuCOkgc384ApwsAf7wzjA4/hH23723vjYLv/uBOcyzttwnFNk88+O20+9xjcl4ICP7wSbj/Sh/ff/TSHj9mjL9enZhw4v/js/KIrjOInamv50/qJh304ZLwqd1utWHyvCnaFxmnlZ7RtfgrvzVVECnjQCPa/HSgLdswUEPNrjaGs4AXSyNNMVp7+kztDj6w/8ujglz4JvRiD/x9ZsPyLVrwPrcJt8VHk4uyV9+Q0FH3UL6uepUz8V3xoJSXb2biSjFc32heEDzWiK9lO6/C3jP5yP9AineaUjBtf8Vw2uv0FUwjsEEjynk/b2f8b+OSH81/j0XJc8rf1sYYvSszLcbbdE5w6i8yLeWi9tZ2xVuC/ozkdKbx7oqZtmN0SVCcdyE0dNxT672qclGpMqDA2KP6/7Udv6dOKwWv/ruN0bxidOadD6W+rNQ8ts4QWDabHCCIUdE3uvJawoA29N4peRL0wc/tuM41uIJCKsf/BZdoR2wa2iDnnpD1Qezgl/lme1cisi54k1Fn/vvOD4bogrZe8q4JDvp8yxvlv9sfHJ3zZB4tVeOTvoXToWXjhej0dGeelgOt4gfiEtWvARtu0wb336exwOCgdG2Q9PdlIFnbniqd/TmBnlZYrNdksPkGRq6r/RmOAvcoRblOW4zcOvW/3cootVU4XuSAxaZuPzgAAAAA=")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPP_2_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PPP_2_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}


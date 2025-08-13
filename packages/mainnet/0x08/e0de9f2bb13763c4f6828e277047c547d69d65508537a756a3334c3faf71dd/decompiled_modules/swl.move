module 0x8e0de9f2bb13763c4f6828e277047c547d69d65508537a756a3334c3faf71dd::swl {
    struct SWL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<SWL>(arg0, 6, b"SWL", b"Suiwall", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRtoCAABXRUJQVlA4IM4CAABQEQCdASqAAIAAPm02l0kkIyIhIxVY+IANiWNu4XPr5xGs+LfkZy9u9OCB15xyIQG2A8wH8A6S3oAfqX1mHoo+Wv7Ln7S+ly0QVqMs/SRtCiEVcvKbOO5x3NtSmQS/T+koiSObjH+VveRVGX+33R92pXfl+KKdDliRzn2by9EB+L0dfyfZi2NHElVCSSjc2y8psYAA/vzlv/+kQeIg8RBsyf/50XWp2I1oQ5mDhaAOKXFy23V8beFcKxzEB6MUzIILMXfKOxHbfVNCjCeykmTj+qlU9uN21UFmiUsZ7e/SYiz/IxypuzBs/IeLu5IPD989gmfd1lqqmbSoFD4eBAo8TDzMtUxqXUl4oW3kEH5YfVMRl4Df31L5hCft9JcN6J+5jGYH94OfTUHOro41aKAtlXj+usXSiaFjVifKp0qvxzWD794q7snFtK5mRV87UGSExv/faru+HDin9TLoXJ81Ar8AyINK4mi6L5dSBdBf2WKPOsmRTE8qUIO0zjqD3yYurJGBZqLuQkMv0vyZwk4FkGM8D3xKAJagE+iFpv0bHTSAkJ/RiFH9QN+VoCbrgXgp0c3pn94zMvCv3gIxTrGZsS+IDPpvWbarOk0AVc+oJuA6aFNZ3RkCaZ8XM//EsGY5ef+aNxjw9UaZxTQgyU6iLRJCfkNf+029hoe0GPcslGkAmI2uS8o1SqXnDvAuMfiIed2tH8k1EqKWpIu8uwHquLLh6N1gsXSy9mJCoCTw8Xtcq+gjbSkNeazwyDfjUJCuy+uGAgSBmoWwHefPFpKo2Ngknn/KeOdwGw+HAZfv+klDPebZuQXlukHtW8n1UggQ/DqPs71c+fJ1L24mtmBftAlLHFwm8X2TjPJXih/8O/mrN2L5b1zv7H++JuzpHf54x2Yy9GNrhgV38vBj1ac7seS0kgADDi9SvB26ABjR96jDjx0tCJvI8Nh0gAAA"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWL>>(v1);
    }

    // decompiled from Move bytecode v6
}


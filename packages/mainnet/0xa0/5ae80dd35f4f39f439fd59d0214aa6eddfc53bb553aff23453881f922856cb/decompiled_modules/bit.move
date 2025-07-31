module 0xa05ae80dd35f4f39f439fd59d0214aa6eddfc53bb553aff23453881f922856cb::bit {
    struct BIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<BIT>(arg0, 6, b"BIT", b"BITCHAT", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRpQCAABXRUJQVlA4WAoAAAAQAAAAfwAAfwAAQUxQSBkAAAABDzD/ERFCTdsGTPiTDoaOI6L/STzeFXEBAFZQOCBUAgAAEBIAnQEqgACAAD5tMphIJCKioSeSKaCADYlpABbTKrtdV/lfx2scfSm5toJPIExq/6r1Es/mbAR7xLqCAiXUEAu4rXPo5UdA14cgQyqyTQhnhlq7cIenv1YYSBYXbiF3F5KuB4JIUQP0unoZXIodnWb5hwFV/dndJ+Szm71wDby99vqUQgzu9HUh89V/rrx/cSOI5MSNgvwAAP78XNABI/+yrw8qu+/6hQ+r+aGORB0jS3FPpLfd4Dy92PVTjmtJ3aJEhF+kJGFr8GdJoRPJWz0imdRJsbz6GPa6IyHCY1rBPLdfzJf5UdWyIeNf/sOPN26//qE7YmMJPowt5WtF+xQtBTz8IMSvS+VmdUSRFqs0zTiFgITISPnzIYrB/YWPsqgYjSvQGMMf4WyGgeUKYXT7GhTx/q3uVvbrmd8KC8ZJzMUdq7ff6F3J/vUf1E+2CMnbknaP1OlBl5SvKklsD44BNFmYBSD/1yw72L727sbwJ6SG/4GWo6GZx33MmuvwPi7/zV1li3sI2A6gTsD6/p+/bOmLLtG7gf7QARRq7S+6Xp0i9h/IZAYgpLfzwDYDbG7Ku9NtrrX3ZX6g1b1PM/sCosiL6R1CbmOAKPVMcO4e+8bSLtf9L5fOi7NVlVkYONDqS7xvqUKfG/6BC+0fVG8/G5Si7wiujf/vhQckMWbZnVFkisnTjLzdpzeQfLhbUg8bAvmyOq7IdyNriOcW6cHF9KxfLEPeeLMSFYUYdAiV6wo2B+f2xC/aIIlTDWdZA1O/15I+4/1USPido3TuQAAAAAA="), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIT>>(v1);
    }

    // decompiled from Move bytecode v6
}


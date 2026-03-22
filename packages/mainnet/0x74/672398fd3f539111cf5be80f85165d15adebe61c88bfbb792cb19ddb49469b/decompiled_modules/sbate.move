module 0x74672398fd3f539111cf5be80f85165d15adebe61c88bfbb792cb19ddb49469b::sbate {
    struct SBATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<SBATE>(arg0, 6, b"SBATE", b"SuiBets", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRi4FAABXRUJQVlA4ICIFAAAQHACdASqAAIAAPm02l0ikIyIhJJqo4IANiWUKFryJcD6Tu3r6AOY76T/MB+tP6Qe8B6APIz6xr0APLF/ar4M/24/bv2bbmB4J+JX1B7AaA30YfAeWXfvtZf3X8pOBs4r/Qf8zxraZXQA8OjuA9sv0V+x/wGfzD+ydZgXfVEXyBwKi/xpW9A/Lkwtt5RBHEZdd8mhWi4l87n2XeFvBClQ/5AnDo1tGVeNb+EW56Ova1FIjCl8RheHvovWx+pbeXRMuzOuawiKGWu1YoJWVAgd3uT9dn7BmMNiuf/5mri7TH2/+NK3oJbM+AAD+/6EOABxuNE0Xu/OnSoeV20rGZNB8nvv8jlL3FIR5vxEruJ+ftJBNWaADgndv8PCc2E3+JXm9yFutCrHJGjeZvcEQweiwHqClv4gVEH/w0fTWemJbw/Jf/3/7c/EH37SNAs+6ND/dIIVaupU9WvKRrHFM2bRatZVOaJ9UwenYzi4CJ5pg0utgh+8s86Th8cdvx6AJ9lqaPkfWmpELAr0N9lzwiz/RwO7odh+8jf+w0Q56DjPLLn1P5fM8Bfv+n/XZCj/O+xGpEgMdWGgrP9mQR6Nw/FFz1t9vhVOzPQ7p2+9VegqnX/hlFYS0fQJfhUw7Lfl5Lf+bewQdMpINNCsKjkTwYHbDu94OVAmoEJHsPvCTA8IKfrh3ih3xZK176gwGxLFi4PbRL1amuVJ45oCbtlNllQrJWuOWf/oq0t2pas7PtsJn+lUG0yaF5hs18G8XjsdIhfdbtmiDTzG0GN9m5zxuOcAr4ECG/Za+pryprCSpEJKsjA/9P8l44TodAh35AY+1B9PTgOx6cT0bnFe7gCGJFU3IOxT/AvdO5WgY8/Q1WVPwPLUxXqzcT/uyfSOKO6JYn8oMWwg3sh483jE06WsK/yv9cTF/Dmpv+rwLzj2W4fGvpr0TuA9rrl19Mlu39iUSA+gR2ksvltMQaaogx+8g+/NpuP/5bdsdYMBH6EUtguHvNHPfPXGxUfXnJgnjCfub0dT2Guu2wNNofIw7F+dJj1vSoJt1CSFf7pkXKW3FS7xWEktmUirm6QdcRttlG2BCf7JI+NOq1xVbH+eeC1IyWKmqIOfGb9PHsOjVN0ee9K/25foyNVBhUrreT7aG8jlwY3wqf7ZoeGwCMkTqnVxd5spyfOn4vm90z/lzIZ0/kq3F39wfDUC61eumhm6j5FAzPvh6HKAD3xg6o/jctJM/364gbJ5S+EReZspPk6XZlzG0ks6sD3DygJYcSXW51lV6jFxV370c1Ju/wb/UmGrr8j3/UDxVNl1Mft8JkOZ0CsugXBOhZkITNHHanE27D5TiekmxDM23/3RS/3NV27t/t2rk7Ebful9St+V26k+nn3TYS7+ydz7NRbtB6gEtRlp3aCkNWux2vbGPYvpHQ8Y3wnyoBFr5ncTc09aNGvbi//loLuGdg3CmAyvGPMwx2m7YGeuH4jH/jeZzZlJQH9O/EaCiplsrCID+x72V3HCXgopoMXdTpe3wzGhBxAiD7v+QRKIo+8gr56Quzutld8zR1g5mxQbn8rMxYgP5vuoL3VSk4fv8V4OjpyCvmKWjYd+CBiuu2xiZYWeSrasFN7DZihu+fdA6ioNqK3lf8KyKZ26DOinmZfPA7mbvnE/JoJfobZN1fet75dYYRc/R3Tc6SFzyvwAtmocGj9l2sGpJECbXph2xyiHpj0To9YbCnmjyDHPohxJ3WrEsBTIGLeYAAAAAAAA="), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBATE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBATE>>(v1);
    }

    // decompiled from Move bytecode v6
}


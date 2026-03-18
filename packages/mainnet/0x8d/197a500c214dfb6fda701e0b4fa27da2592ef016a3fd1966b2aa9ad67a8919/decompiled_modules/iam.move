module 0x8d197a500c214dfb6fda701e0b4fa27da2592ef016a3fd1966b2aa9ad67a8919::iam {
    struct IAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: IAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<IAM>(arg0, 6, b"IAM", b"Internet Agentic Markets ", b"Internet Agentic Markets on @SuiNetwork", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRjQCAABXRUJQVlA4ICgCAABwEQCdASqAAIAAPm02mEckIyKhKxl4YIANiWNu3V+QYv901f7uVFI8avqz8rjoAeYD9kvSm6ZnfQOmK/a5usEcACq5xtXDDa7vbeC56nRWzucauRmnSPB83AHC+Wpx4FeW0NUXhAzv7IoJgzmyO72hNJVkaiXZ61/zF6Pd0k2K2v7fAyX3TJewOn7Rs3d4tUn0g96gAP770XSgBtrukmfwvL+SVlmno2m+5pJ37zQuoE5Ldx0UhXuIBBZP69ZjqBkGsfvy1+gJ0Sos/2XZxP22imuBEoOr6YV0e8qrgqgsWxLOur1Vb7G/QnB/9DbqwwMDUurR/i8c+6ueGP3i91paxCTkyKrNMXcZrfGKjQOQF6154XjLQde96D6Jdwqa/F1XoW9Ni8r7VchuHI8TFolzQX22xeMUlDHXo7LyoRQ5SPbvj/rmHYEZssw8B1Kvfge4W71QT3uNtxx/Tf5d9wJCTj4pyN+s3ETby/xjNDmLFe3/zdr49aGOMsUcn+qJHGMW4aGw6YWzjprMh5kjGHgKCdfT94j0GVXAVRwAxQT4tBmwMqKIcIndRSYnWxYED4Hp+nvhXjubsgBDLWtpIMKt1nmfvjuJcPg/YLhWmGPmNDj+3JkNnxtcElc4HmsYeYNNbU2gA0xPTHeqNH7f2rPcq41lcOO9tYlDayTlZpoZGcISaRfWz5IrYiLhVr8p5hfhoJrHztVmRoRZYe/MrYbbyHx8FgAAAAA="), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IAM>>(v1);
    }

    // decompiled from Move bytecode v6
}


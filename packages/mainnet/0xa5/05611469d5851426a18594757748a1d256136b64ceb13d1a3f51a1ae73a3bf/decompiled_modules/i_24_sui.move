module 0xa505611469d5851426a18594757748a1d256136b64ceb13d1a3f51a1ae73a3bf::i_24_sui {
    struct I_24_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: I_24_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<I_24_SUI>(arg0, 9, b"i24SUI", b"ii24 Staked SUI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRlIEAABXRUJQVlA4WAoAAAAQAAAAfwAAfwAAQUxQSBcAAAABDzD/ERGCTNqm/k33LBMwiOh/kt45MwBWUDggFAQAAFAWAJ0BKoAAgAA+bTaXR6QjIiEomWiwgA2JZwB48D7Xz8HBLPmnUyReK6FP8ryGcfno06O3qP0aCD1VVVVVVVVVU9FFailuNcsaaXxc1tYot9jauDVpve9NQRAE3ILJ4LhPNcp4Jz784skQXuA75xFcd3HoxNVYVr/fGWdXtxXXjuqmwDEelKTmiLqn1uxnkkPqxx9jId1rrT6RvKf7USs8v4ZUpE53PwQv9kA7fKaLT+QhTYXdVVXA6aAA/vl7AACGcsG6qpCWFlRpN/3tl3Pw43GPWTD7vCiypF7OQeR8ThgqBMCQDdmnimFQcn561JCw4YPBsK9h6ATw1fQUJuw5eUJoImQY/ryNPwWReEqTjCDGL154O5XV7u5idjVytpnJZNjk/grWXmpIHr0UzxYS9jcNzwjTlz2xHHFH+wr/Vfan15fUICW/YcZeqe47B5FeAgSHKMfuOs+p5TgqsHPhaww3B+3UeJ8XqYm3F7gVefgMhFtsF6g1mz8DLIlkkGj0XYdHyfJIBaNvrJvrzTkLJ9ZktJI/tQdn46u21/KiO3TAEHTVZCj3eiR1+Be3uB+VMQrj74ISs08IuSXEBZdb/IuZeiJCXp70KZpczXw0c1SH+RtJCcLgZG7BRBRnPI6R3NnNYII3fsaXeKZaubZmkdD1yYEjU+eeQ4e5vxIDtw5hZr4H/uydrOfO3wJ5ZluM7cVOTK63EuXaSLFTmoHciLDAiu4n0gFUTUComsHxNj583y+n+Y5XVvw5Yt9zCGxJvx0u8WL/ZgsHrpW47uLnHnMRbtOmsUsj4HuruWdB+3FCjqHoR6tskGH+Kly+RQID+M+X78hLwixL+idn50srwyHrwxwij0Ugnp5XvDmXnH6uhy47gwow6V6ZaGUPE7B0ZvsoHGsBfJiPmACgOri24Dogw0Bx7y8DBmvbG2Dl00KUhifyODRUal3IYrAuBzrzrNo9bR2JUSfeaTF1y9ZmAth/jgUZKJ1B0BX0MZ0v9YSSedmjXMMHnCAvJV8yS8iudtchcOm7MssXghlygzD3QQOVB1xlcc2DKNro3t7FwpaSnSRXmWQ1HtAOO5+RPB2l8OwOoczUWr5jjO92B2mDGdjcNEYjiVeN3F3o3upzbwCSMBPbf9q6cMLM+l+Ul6K380mfUVYj6GNpMO4mtA1hE+fZue/4DzhCXIpUCP6wsQL4BqsV98P+TsEAjWBlB/xK2ixGqqHugHw8CuIuJ8nX2wEJymm0RL4euBeG2IwPwfjpE/pONgzKc8n2daGv0cB6x4xZ0Ld19aqcrJ+Jq3FzOLPmWqp3tD0F4nK+a4CTNpWOE0/d4/y1+dbILqej76PuSZLOqewNohHPmIE7yF/dkRjC5dVZPdIOe29r0R0AAAAAAA==")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<I_24_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<I_24_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}


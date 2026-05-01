module 0x414470b4f8f20e06a61179cb84379c76e66be7704b9d766d1d7c7539c84f8fcd::msend {
    struct MSEND has drop {
        dummy_field: bool,
    }

    fun init(arg0: MSEND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<MSEND>(arg0, 6, b"MSEND", b"mSEND Series 6", b"Suilend is a lending protocol on Sui, built by the team behind Solend.", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRsoFAABXRUJQVlA4IL4FAABQHQCdASqAAIAAPm0ylkckIyIhKpYZ2IANiUAargDKGWtARlhnzqH8f8r6tNt55iPOc9G3+S9QD+4dRJ6AHlx/uB8IH9s/6vpoXjV+fr68xrd0+FumYaZKu+AdtdRnB5f/C80aXT1xfiwDr7X7nzL2JsaA1TAnjmArCOvD09W1FZuvCstiz5ATPx5hiFKM931lcPyV8VghivvUEQKObhFJMHP1sKF+fdRZ3V0jMaoDOAtjMuRrFio2CeDTREE/+xXb7uX7L2FsU0ELylrD3D6bCdnwvKHep0ZL8K+npK2QiVbfvkio7ROTdKP30/TGST7FggAA/vw3i9ZcyN8Z8LgABd5Hgf5m0GdumRw47lrPev946F4xnzE5ZZdsjoyeW52cdkYtl4qWUlpZ+9j4mZ3jK7PYJf89JMN/9nPJaFUd1yi+H7gkpzaaaU17uASRHz9qw1sjp7RvKqPp57NAjm7ah2PP7Cs6g6Di26TMOnGCTBKikVK/k5EuBXxGtSXDS7bIaUWb44/0SrOQQyYlLOlume+/r0Rpf1WVWwD4UnNX11oP3kKXEg/JArMrQAPQbxu06Ad46lXx8iJfdAma3ycAUDXmnXjaFl1BMnBsyKwsNl+nx1E0FysqBKly4n1TQ2903h41qDr8WmCPRQtrm/4437j4LHZc84Hsvc780rTodKlssFytP/HUpxAbQEHaUN/31H81s7MJVBUbLwzx1WNiLYp9hsiXPj/88/Si6xIdvfcqwb3dKTh0XFY8qOC5Nxj+lYb2jJseudooLMOjgOTvjelDpIgsc4hPSuRBmexR2iI18OVKKjwmH++XP2f2xcCoV330uA3RuWkq8xilAzLDXVfO+jVCyv9XMFPr3G8n/PD0ZpjUK4JtoXngXP76V83TC6RyW0zxxbB4qPWvFwwC1541pJ2uAyd4aCVznnpnqetk/jHFplSGwh/7U8fb/MzbmGORKqaGYMeIv1bBwxQhUrNPjyKm7GvwCmOps3oo39edz14Y1qecL0OGYOCfkvEoJaSg3e9Og0LrKUNnU/qkgSkZS7bYkdPAp/8dmT6i1fzB+99YXXDh5U+BN8b11dhRzmEkfvLuPArKXrw5j2sGxX3ricDSAiDtgN0YW1pWLLw+Bbn8ov7UEC51SkIqf6X9sXNfPdQgt6/ZM5VpbfqnT0cElK+if/pC9oAT4yM6Sr7COw9N8o3w8vlSbqkXAaVmsGbfq9R4cu9D9PdMFSREYQPMTeaesCxazYG8TVZWGAVNlF2IthXsC/zbPlqt+2Pyv3FaajNK3lHG3P2uVB/78oCoqj4IAaBj9Byy9wsNYBU/Q6lG2OTugblp3Oyg8lxfjCeodc4/jotLdEH+PgTKeRT19Oo7evV0HXyekKdgIY7CxTPvhDuWERU6GxhO0MqhZpldMP0Wv5OvmlPHA3hTNI8HSatWyhbpcC7TlNc7/Bv0PdqkHvf/Zcn/GPzfBxN17dVb4t2CJvQlyvlqoTXJIHil4IjQzpDyxXI9ZmvQzkbO9CkOLhK5JtuaMvOec4bIYHLAa6t5pA5aTbHs/TpWHzkzqbtnurJ7BWeRVZV2dVGKV8sSunXc6op8EKrYz3mUdoO7sLEUf+jszYzTOjflSUHfjLcDzmjmqbh9fKSqOsLqw6VMCV18eopqVlqACG4usS+8eVB+TCR2wmiQw07v0Z5AL2IS+FKFTRY9cCE/3t6nHOIAH63/nPWX+9DBC1//owOdNyaRRUDSPt/1Hi59JE/Jh4qrclnBtBOSuOA2LCHxuLNVOz5OkAeK15zNjTzaxPd4UY7wPzJaB/TprzGeMSKfi1I+W+8BD7trMGx9LKBalXVrl3Rq+utBukOCeUhfnCQkdkgQSsBEaWBnOOulVwfhICh19iVqMzgndpkaXFT2YojvIeoK5DDHHTtFEuMm/wTNPmVvInH/DfXJ0B6zN5MNZmum9aYAAAAAAAA="), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MSEND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MSEND>>(v1);
    }

    // decompiled from Move bytecode v6
}


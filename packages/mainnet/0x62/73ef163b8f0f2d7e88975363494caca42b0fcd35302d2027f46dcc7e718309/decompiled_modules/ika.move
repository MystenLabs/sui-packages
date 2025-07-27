module 0x6273ef163b8f0f2d7e88975363494caca42b0fcd35302d2027f46dcc7e718309::ika {
    struct IKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: IKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<IKA>(arg0, 6, b"IKA", b"ikadotxyz", x"546865206661737465737420706172616c6c656c204d5043206e6574776f726b2c206c61756e6368696e67206f6e200a405375694e6574776f726b0a202028707265762e206457616c6c6574204e6574776f726b29", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRqwCAABXRUJQVlA4WAoAAAAQAAAAfwAAfwAAQUxQSBkAAAABDzD/ERFCTdsGTPiTDoaOI6L/SXzeD/EBAFZQOCBsAgAAkBEAnQEqgACAAD5tNJVHpCMiISwTWDCADYlN26vaOO/jBUgdVz+5RgB+lfsAfqr6VX63fAZ+vn7d+1jLgOesb9/8dcSfU3/k/HXqC9GktRPh4oRabWsEemhVPCMGUzt9KMswIGi9BWjGdLRS2F9xDqfIBjsAeWNf0M75EDfXOFpmhC74VFl3HuikL6siYausWLn9X/gA/vz4QAbfUB4cYKc//5YBdknXHvZ1femmRbN8uAhNAESk139DLi9W13HZZPhMvqjqe9Tv+qLGZFz/P2rcFMioPn/oQxTiuHHe7zu+7/m8r5VzJf9ui/lPmw5dL2NZTSw4V4pevcJ9znmrZh1CF/i2eCo1f1TKPnviho3nX6xaC22/9DruwH8lKs7omuPsL+9tNvH0k14/m+Skekf9I5aHgiua/G/03lM/YTwtzGwvfW0Ff/jz/Si/6MtXkHzcANmx5HdNesLKCZDE+L5nSGeq9f5I/8q+Rari2RMp3Bbn+4if91LVVJAYP7AFX+NJ54NNyiFfVZE305vp+GRc6UkEV5/9BrDNO39Pimpj6iYb4hAMn4XxUruxxnYO20zTu2ZTr7Gn+xxHuTuLLEjjxNtmFS9L3fXwPznUllPR8yuqGQcLKxVfjndc6lg9CWXt/EfLLPn6jmHVEd8tKt9v20XEWcEqzzcqDMoypfCQerWyiOWfcd6Px0rNmLCDV9uOJqiQP35NEotlUcf2GQbANyzzpTBQ/u8VfM/Emjd6gToJ+txyPI5R/ucuu80N+RuAAOzxnIf/+8wXpri/h//kgKbWkrmZZcFrfT0hJNOrEEl5RQ25kAAAAAA="), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IKA>>(v1);
    }

    // decompiled from Move bytecode v6
}


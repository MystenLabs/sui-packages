module 0x23b9865f822cd78f240e60e8d8c00f5a3652e374aaf626efdde3fc3e6986a574::t {
    struct T has drop {
        dummy_field: bool,
    }

    fun init(arg0: T, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<T>(arg0, 9, b"T", b"Gt", b"Trisss", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRgIFAABXRUJQVlA4WAoAAAAQAAAAfwAAfwAAQUxQSBoAAAABDzD/ERHCTNs2ZlL+DPcFxaSI/gdcVQ28e1ZQOCDCBAAA0BkAnQEqgACAAD5tLpRHpCIkoSeUS5CQDYlpANSS9+fsnzbiOKy8OYzrnwVB+mKaq+QtjAv4TUAKFv3P/IZKfOJ9aKvpCmYPVOJ4/ApclaIP8FSuCeVg3L9Ymu2Vu50cGHUBldrKNLdF5s1QOfnzIC75D+nsLEauIimI63gn9F74lp/dU5qM8PaGLj+ucyyad9CHizoMqdp4d2XBmy6leqzV7EqMUisz5f9ciq5AwWfggN0KX3eOPdh1pPBkDfkqNF+7xE8bvdOQwlUVr7FuFsvwwsKjpgAA/vz4XsCUp3lYq6WXAyCq/wcH3Wp5UWNV96xein619G49vx3EWQyrJv+eHSzWunRg0E5KjShfA7Em/bzaU4f5NinrTmVBDq4R4cBBy0C1RzLfr9XIUShO0fNFdLK5Voky56aUfG5BpiIQhPwdXHt8eEr0sv/Wp/5EWMT73NKDuHr6Yf4imORewebs7T+z401c1QhMEzEdvGBlXKOYVa/Icub7DORdeY/Zjmp4PUv7qYfI97oAC2g74cVHvQ3qTYZzfxYQR3xxj8Exu2jLnGLT68BpIcmWbKBztVql1itNA9BbZfW0ZUdmSFbfnWULpyB9Of2Ru6rCbQAqjuqNYUEWVWwqRYlKE2HG5CTCSn0/ZgHYqOraaKClRY1rC+0H516y5ejP6cHwENu6V1U2LaXmMP/Y8JXAyqmrodaESKcMeIqDXi3NGdgbKXw+SIBeR1kcJ9Ah7Vz1R8ZjJnKnwTpP3jDrbidI/Z8dmA/LYlNp3oL0ALF5Oygyj589y3bTZ3pZdlwucJL29LLctP6BzsKkrOQSUmumrPPXL7mKFRscw0DOOJi9rUhNF2rjWeKTTLG5D1uZiTlOtl8bmiatF/gZzMTnajBEHCeWLWwYIHGnq5tqeeH07eVL6VcXcusB41LWcVT3kKvCFsZY7uiSykN2GvZoFwc/2/6sJjvc55/5fMFtUdgctJEWPFxOUX5QZSX30N5ju+ANzxJ+QwG9M/9D6U7UqzobrLax0HxKX9CJcJQbYkPYF3t7lOKZOEW8MTQamn7IJ2gJB8itxjXO1juP1+EAKr/le72ecYv9r6NNde55OkP8BriOit8EOM8R/L+bO8pzKQYkaw/RhKnt4gi7ytLVU8lo5ofakWRZiQBGGqvUMEPta25yc11rAKwJfNEVe8M+gqqqUl62kEaRodOz5EH1BKHI7iQxKTscn1Yt1djYYSwna9FAu1dpxe9vVy2wfTueCYFK1pyzRec3JRv1feyB2JmxX9P7yMjoHTFOggdBgggjDH3FoVi62jwMyifjpkTYsgKN5vbS+gYQw2EKvShnoysIuYj8nFsrKNHs5h+dsD2YwKtEubVRk21YGOursbZ+sz1zHCZ/c3GT7P5fwnobOHgDFwOMc2b0op4V+wysZluruRgj4SOtAZoQ6PVxESKRiWaVUt0vaV93Lkw27AcT/xPYVaiFMWdbay6GUncLrFVJTe3VZKTVDb3DU4M0Q8ILdjBOyJ9GbFdPYN6XU8MjtMlitc0L1H/3A70Ajm/49MbICCGZKLt/89LXP89SNIV1p3gzcx5VWSo1V/Lzgl/LUW4J3P1T6rSANpIRMMvGpRRd7s2RIAAA"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<T>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<T>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0x15008e4b36f5c0d712d1ecef4f07456a18813e6a6a808f421ba73c4a7b46fde2::mmga {
    struct MMGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<MMGA>(arg0, 6, b"MMGA", b"Make meme great again", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRigEAABXRUJQVlA4WAoAAAAQAAAAfwAAfwAAQUxQSBgAAAABDzD/ERFCTdsGTPiTLoV5RPQ/sVN3ir1WUDgg6gMAAHAWAJ0BKoAAgAA+bTKUSCQioiElGAuIgA2JQBqnoZ6IDBP/O8jV9n8Hfdzt8/MB+mfrk+gDzt+pm3nn9rvSHiiroTsNlVBAGS+q47lm1oJ6vQDe8v3l+8wQ9psGJ1GfKhTwPfEkJSY5qdaIiGTyv0qe9U6npfHzzaUBTfEe4imbJbEOFkG2shRpCqnWBUoHdlSrjgQdawGXDr/7A42mqBiqPoTZXW1/FNKZNOdsYpg3KNYuCa4uumuB5sOAAP78+EAP3/RfbqzREzNNKImZ+j+KXeO7W4Fu1vwRy5mNsWvC1r7tpsXxZuG5CipdqV03Iz5uTP9Ry3/X/2//NyHb0JV680MMGXT1cZlouTTkD11d1hmMitT6Bd08mkjdMC1ou2NONOuYuzzLpuLHH/kjv3Ub/1/apI09pn9/CyKN5/fqj5ff0iIgEjkhl7c2eTAHHwFcxA2R8qMvTsfN8hFE/K6k0t5ayedRLbaLjr/E/u2GO9Gdahf1ygbO+iZ96sIonaAhNKxIurUWzGIiyk3xp5UyGDWqvLtGUfIgmEe/C62cI9hw2yzVma6O8EkiGf9JvdCgAaEZh7JEDpl0MrMVOtJaesHw+gzmZI/iiGz/whY1xkWun+sec//dW3gH9VeguTY6YVz2lU6R0f98G2NVt4/AYv9h/4348ApkIr0DkQ8/kXu8dId2KYrVlTuBpGH45Az/jgqHXHM34a0Lax3/+Gm229K2eTm+iblhZ3Cp6lReATqZUj5UiHJhvVJT+quQGOy++oCYsiJoRfVA8JryzohftRDxEvtyIUkSn+Md1V0UUbL+r33a3chPY5mSdubzJVK7J9dz9dFNuk6AupwpGucqEIulRrYrjYhBNS7pjBXfx4+7dmsTkZA6+UkopBinyofIfjn4Xmev0CHZBGtDx/Zdj8jIq7uk7xKKwAaW6bfyJ47tB7nRBBlB4IRwc6MC2HzneyyKr/fVVtWq+qs4KUxmhLywnvkBW/Pd1sM677PrrbsGh+Hy/8w1IDFJqZAH2gcpAh7PJneo6awtsouHCgKGXOUlDN8HBsAQ6bjUSUdB1f/kHasOpKO8vEuqqrlXUcYsrohvkfryJNmCC1syAc50TTqbEbBU+ZCBroj+azVRHXODi8mo7XevAa0ZoVNGfKE3yWW+UJ9lXEyuniXxV3edYh3U+Noj0AG3+HjJjf/9xPy4kFB+9wFA5zkjnYggAk+1NOcUiAZ71I1/WaaWF3L78jnJtnrxuedi1g7HKNdr8R2Qw12MhK9ljIYa7GPvskgUHadNSelul6PaKo7m9Vw4hysSwy+HzPeyUxQA/ZLF8sIfqHwAAAAAAA=="), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MMGA>>(v1);
    }

    // decompiled from Move bytecode v6
}


module 0xd10b82b8068665996ab88c1c190d2d879cb6198e7e8611f59fe9f8a873f924db::izi {
    struct IZI has drop {
        dummy_field: bool,
    }

    fun init(arg0: IZI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<IZI>(arg0, 6, b"IZI", b"pepe", b"cool", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRk4EAABXRUJQVlA4WAoAAAAQAAAAfwAAfwAAQUxQSBgAAAABDzD/ERFCTdsGTPiTLoV5RPQ/sUN3jj1WUDggEAQAABAUAJ0BKoAAgAA+bTKUR6QioiEnE3swgA2JaQDViBQK8W+814Phr3o39V+xn3pAaQKZv48fp/2B+kKYh561vOlsu1s4OzDAOX5b07Y32bxYL4J2zUWhAiH9JCjDE0t91imGhWDYytLfdJOeDHoG/ZpgEHRDxebEc2nv+7hjk6LJyTAEGrQsqdMGRP0hJGfFbr1tggDw3DqHT4zCVU/SeqHdv6lYVfl8C4AA/vz4QBZNUTLaqPT5zdTDBdD/avjCCKS8Ta+dkxBdFfhit7Ra91EsriffLCYkTQ1j8dpdtPYKngA3C/A7+Kwhyyp1GFim1py4/7Gza6kRq2qFSaY5WzisYN/9G4ocreGY077GH6FeKvaIX1pnzaQfOjd/Ag1EuHTLpsr2v64+Jg17zyq/cmdCKk1W2gc93n39TizCbwfuJQzWz+dOqNC+iJ7NLTdCV4ynBgi5XV7p1zcV+tvO6OFT7N9Hl6K9NabSJO5pveXY3fPb1gwd1TbyZdK7RgsKYPciklIySY+XvNVmLHje/wXo98ZNdrA4oapvo75t/srEBYVdsZTLMp5O/XXjuqObd14TJsrqyoNhMy0K1Kd2bQqQL72OHddNAvWRRud21306jEuukGeou8949JslMHq1Rlim0shmbqBh14TmIYANlnE8GumiBkvo2k/Kjo0zJEHkXzgyokkDGE8W4JkMl97m2O3y7DVQhQRD+6tnA8qWD1bw/GmQW0UnVR5pDqh59PfunRb3IgyrxCUYrB3HI0l68mvHHmGmjaHxTPb+W0jvMMTOZ6VQux1G23autfMh6WXlBzEyP/TwD4zVNxEEFzHlEKf1Q9iR2Gui/7bBj/WZDeR/jYOSDTDJ/8zfdnzF6CxSiHfJ4AoKssAIaPpRVwMbb256n9I48d3tRpaeWrCej6IB/EY2kU3jZSrA5xpNerFDLtHlZjOlcmO1mMO/K5waN6BzBclRc21EsnxGy7itMu6Ie3gApu+uham8nK0fisDJK5/zChuzyN6PH3jrDzVXxSNcNmv51icZki7euAvdqWZt7Pm7ThQP+DfsmlwGO81yiOEJMExQXAoH/98CVC6x9kCAJtGKIH/3/bp5PWC/hsAzZw5YFvA69AI9IvWRXMg7TIbD3mzJlha4dht3ZGZy78JOwNRj3fr/PnfzFxJ5WdWqPgCNuckPeMv+0BhhoqNtXDajh/P8PnwB7AM26bPsk/ky8fhBLKNUzmAN2uEPgIW0XcERZMGCO+NTW7Cvd0YymaXkLfn1Lz2uhrcf8/IRZc8hlO3IFPmFrSY8P5NgXx8aCy95Oc17O6yzx8an9yjzNI72XKCDiJHHjzAKOqP94JUABnz0G9J5n1O4Fvv/4x/9ZT21T8L0ZQZ6i6/S8AAA"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IZI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IZI>>(v1);
    }

    // decompiled from Move bytecode v6
}


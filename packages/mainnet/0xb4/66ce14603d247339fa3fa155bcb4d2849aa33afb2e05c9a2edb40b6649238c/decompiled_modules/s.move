module 0xb466ce14603d247339fa3fa155bcb4d2849aa33afb2e05c9a2edb40b6649238c::s {
    struct S has drop {
        dummy_field: bool,
    }

    fun init(arg0: S, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<S>(arg0, 6, b"S", b"Shadow", b"Private - Trustless - On-Chain", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRkQEAABXRUJQVlA4IDgEAAAwGACdASqAAIAAPm0yl0akIyKhLhN5GIANiWkIcAAqlj+89r3+E5SI/I/YcIO1b/lN5CHBx0edx9Pedb6V9hH9ZfSj9gf7Tey1+ux4mIJpIOebv/99FWErNquFd9ZVufLhhw7a1W7t+/aGWnwKGG1Sbne4RfNygfUPQNs38Ls60ksj+RPMxcJWQ/VqvaScBNQyLARbSacRAZBQ0TAiYJUeh1rxTxnvf/xe/oMF9OZ+er4F0RqdgFinTPfGvpxiYZfZ0VBl3Jm2HpxAAP7RxwLOuFQIEhzxIfX7ojGUKCjrhzv5nxW2L4AEj/KEjZKQ+VZAPRl1NBQWlqhyRLLSCo/J/6Xw/9ac+R4Sn9YBuRh4yi71doiNh6t+6Mf1UId3G3uWEdY6msme3gerpxXjCafI7KCovN6HvcTxuucFeW9nS89wMNZSbn8W7LqttGTuF0VlE4awzqLmI8i2OWwJagZfKahfpMeIBSfbiSfwVD/HL6nf/BoQ6vL3SmBQkAv77fG84863koRUf7pgmPoXteDAT63RvKY8QovmrKyBGqVTl29/D/B59XuRY40sAxAy6rfGod5NOeIKu0h62U9cJg1v6u1RJsT1CDK3wzICrmQV9AFpP0NVuUCQixLvd+29pG5VDG31b8JMN/vJ1DCnrdPw+Vy+4alZc7RdQkVne4UTCjQZ594IN+NQpp/64YUetv16MaJe/Rv1GEpxojxSLGZza/dhkYxF5tUfZOeLrQSv8bU8qBqH8zxroBsifd8BxhPb/KU7PIKLSG8k4GYE7d34sw8Axfh9v9zyqWQBFBYIVh0YquLrcDmgIAyhFMgdrc/g0GVYe9g9tQo/4Tv3ETP893cfqO6DWINgRecdUErj6mfgJb017DTlU8Fq7cbiK5r6jI+w6lOSh8rscubXcJIQm50KXzwDsrb4yqBEhNx9NPzFbw9WN2R2/71WowJgpuj7D05v2rjp7xChfpnmT/xHf9klH+5QTR1L5nckeJlSy8TJeBZEC7+soZbqU6kKX2GfTKjZSG0fwALbHoPq58BsHW3X5SSVnpnr75/1cg1ZXwU3WOIrxZmUPXWvZtAgUe3WT2JgrU3SdN96OJEK10ZG5zHwnii6OiAN/2M90nBRslfxwt3aABCUyXg40xL0q8WK9UsLBwff772EMN1IN7kL8K9EPl+3u6sST4MLz97kQfLe3GnkvV48PLZfbI9cis4BKaW0Q4vWNCuo3v2EB5xV/Z2qIUbqpcCIl9BtTPfH+EKnGg0phzzXGre8VrlWmKQRHGgqnbb9emEN8pQPsJsfwIGKpP3kthbxx+Pj2pc9ZpD6Gx4y8FlumxzctWQbQjqu4NM3OPn1gjTdLnUfCbWHUsW51pFjPNPGQUKW+Eyjhxeo6mWb/RbM+vSlg3r8l+x+0kSKJ53v7Y/ciB1jQ+QQfQLg94EAAAA="), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<S>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<S>>(v1);
    }

    // decompiled from Move bytecode v6
}


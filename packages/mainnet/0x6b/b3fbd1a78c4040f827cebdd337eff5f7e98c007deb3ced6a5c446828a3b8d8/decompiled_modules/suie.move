module 0x6bb3fbd1a78c4040f827cebdd337eff5f7e98c007deb3ced6a5c446828a3b8d8::suie {
    struct SUIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xf4054b4c967ea64173453f593a0ec98cb6aa351635cbc412f4fdf5f804bb98db::token_emitter::create_currency<SUIE>(arg0, 6, b"SUIE", b"Suie", b"", 0x2::url::new_unsafe_from_bytes(b"data:image/webp;base64,UklGRu4DAABXRUJQVlA4IOIDAAAwFACdASqAAIAAPm02l0ikIqIkI5SZIIANiWVEdx/Kbd8lz6k4bwgyruAGkCmTeND6N4CXogfsAKs1t+08BTmJEbGimWhbtHVR/lk/0M08T2P/+1WexdepA+BczXL2rOeeQH//67dC/gtckUzQ6OTxYxqnwI6U//QETVyBUtOGnz0/qEhgonAPS7/7A52q4dgFo5hEfsfXrk1OFpfsj8oeHBW00xeTlkOAAAD+/gs0lwDG7qv4oeLNdY7J//nclT/+UQg/mKd6Cdg/oyMmQ/ezQmcaZ1UM4Wh9VEqvGU8677WVyxJ3txwja23Oyu/lsri5mCWH5DBuUvkHSJ9o49cfQxKsE6aLAS3DhgGDqX1rwpbC3zMluXggfogKU5wNUr/ecOa7hgnUW/U4G46ePYk//KKz9rKSrbM0Ibx5U8rLAk5gKDqEIxWYZwXOS+iuwGRJR3MegkrHf1r39t/V19UGF5nLbwQshSV0vb8tusVGcnCzTMZu9wIcLeAU2YZqBQqcJkArhC2FnmNa/UpdGOZItvY5v4pIjRM9Gl4d33oWPf+3COnr2A/3q5kWXPIcjx8tLI0Iy7vSN0emhsIz8XolPTl2My1IzCrXCN5bOuVQoK1Vfx0hCo//qPvu2V8PfbSWg2QGxKZHAZx6YwFhUKrBJO/pW6UmFKN/t5Wq1KpR19dF6qW7v2GXpY7lwhsQIP4LaJL5nQRoW9gAX8+8YpoIwPzuGQNEs5/Wr3ZsS7waBAPbYdbjD0+0TyLHgcdV621R5cdzfGrEzOd97PVDY67bmkQtnFm+e4juPa+mlNTd41Lg02xl+QOxwMqA9NHZp5g345q43+8QnsH9rRKzZKLAPzjqkxjA4cou3NhjJ1jRv3ExGykIuimehT5T91csBYBzlRMlp6CIKUs3+YgW7k9GRx/qnLWmE0hog9t4i28o2JEmWsqBMiMtaqaprMHu/abRmrl91JURIzb6qvL9UU1/Ruo/pN7pmP1fWI9s9kWZd9S5Xb+xE+ECUBlsYMdM8bAt1QtEW4LQ4U5QtRLbwPGfxpf6Kda0GL0DRjL2nlPxorXdLAtq8sgY3bcgwvq2cqPwtiypRn0CRJQiz6viKxQ/y1cAedhvOBZGgrbI5Tm5PAAD6Z/KtKk7c4oereCj0/b4jlBNJppD1OjHj4OFsbM4rYp+7oa6RnPTq5Q4uXrhzLbmZHP2dN+yYD91NPcxSbfaCV834CeCLIesdYa44BRZLZeQTRUPUFB7OAA01VqAFLdS06VEbmoL4rT7gc75hzKI9RRH9ernB7MajQLnzCOJ7ZFQBLQDongKQzoe4C28fAAA"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIE>>(v1);
    }

    // decompiled from Move bytecode v6
}


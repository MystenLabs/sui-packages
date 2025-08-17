module 0x221cc18a8027dcda22361b5cb56159e8f9986fd68acd09b8b906b5ad46011e3e::suihive {
    struct User has store, key {
        id: 0x2::object::UID,
        username: 0x1::string::String,
        friends: vector<0x1::string::String>,
        posts: vector<Post>,
    }

    struct Post has drop, store {
        content: 0x1::string::String,
        likes: u64,
        comments: vector<0x1::string::String>,
    }

    public fun commentPost(arg0: &mut User, arg1: u64, arg2: 0x1::string::String) {
        assert!(arg1 < 0x1::vector::length<Post>(&arg0.posts), 13906834414861549569);
        0x1::vector::push_back<0x1::string::String>(&mut 0x1::vector::borrow_mut<Post>(&mut arg0.posts, arg1).comments, arg2);
    }

    public fun createPost(arg0: &mut User, arg1: 0x1::string::String) {
        let v0 = Post{
            content  : arg1,
            likes    : 0,
            comments : 0x1::vector::empty<0x1::string::String>(),
        };
        0x1::vector::push_back<Post>(&mut arg0.posts, v0);
    }

    public fun createUser(arg0: 0x1::string::String, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = User{
            id       : 0x2::object::new(arg1),
            username : arg0,
            friends  : 0x1::vector::empty<0x1::string::String>(),
            posts    : 0x1::vector::empty<Post>(),
        };
        0x2::transfer::transfer<User>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun deletePost(arg0: &mut User, arg1: u64) {
        assert!(arg1 < 0x1::vector::length<Post>(&arg0.posts), 13906834367616909313);
        0x1::vector::remove<Post>(&mut arg0.posts, arg1);
    }

    public fun likePost(arg0: &mut User, arg1: u64) {
        assert!(arg1 < 0x1::vector::length<Post>(&arg0.posts), 13906834389091745793);
        let v0 = 0x1::vector::borrow_mut<Post>(&mut arg0.posts, arg1);
        v0.likes = v0.likes + 1;
    }

    // decompiled from Move bytecode v6
}

